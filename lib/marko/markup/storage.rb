# frozen_string_literal: true
require "psych"
require 'fileutils'
require "securerandom"
require_relative "../storage"

module Marko
  module Markup

    # File Storage
    class Storage < Marko::Storage
      include FileUtils

      Failure = Class.new(StandardError)

      # @see Storage#create
      def punch(storage)
        fail Failure, "Directory already exists" if Dir.exist?(storage)
        Dir.mkdir(storage)
        Dir.chdir(storage) {
          marko_directories.each{|dir| Dir.mkdir dir }
          src = File.join(Marko.root, 'lib', 'assets', 'init', '.')
          cp_r src, Dir.pwd
        }
      end

      def furnish(directory)
        Dir.chdir(directory) {
          marko_directories.each{|dir| Dir.mkdir dir }
          src = File.join(Marko.root, 'lib', 'assets', 'init', '.')
          cp_r src, Dir.pwd
        }
      end

      # create demo project
      def punch_demo
        return if Dir.exist?(DEMO)
        mkdir_p DEMO
        furnish DEMO
        demo = File.join(Marko.demo, '.')
        cp_r demo, DEMO
        Dir.glob("#{DEMO}/**/*", File::FNM_DOTMATCH).tap(&:shift)
      end

      # create samples dir
      def punch_samples
        return if Dir.exist?(SAMPLES)
        mkdir_p SAMPLES
        samples = File.join(Marko.samples, '.')
        cp_r samples, SAMPLES
        Dir.glob("#{SAMPLES}/**/*", File::FNM_DOTMATCH).tap(&:shift)
      end

      # @see Storage#sources
      def sources
        marko_home!
        ptrn = File.join(SOURCE, '**', '*.md')
        Dir.glob ptrn
      end

      # @see Storage#content
      def content(source)
        marko_home!
        File.read(source)
      end

      def write(filename, content = '')
        backup(filename)
        File.open(filename, 'w') do |f|
          f.puts(content) unless content.empty?
          yield(f) if block_given?
        end
      end

      def marko_home?
        marko_directories.all?{ Dir.exist? _1 }
      end

      # @see Marko::Strorage#artifact
      def artifact
        return Psych.load_file(ARTIFACT).freeze if File.exist?(ARTIFACT)
        art = Artifact.new(SecureRandom.uuid,
          'Marko Artifact',
          'tt/artifact.md.tt',
          'tt/marko-artifact.md'
        )
        File.write(ARTIFACT, Psych.dump(art))
        art.freeze
      end

      protected

      ARTIFACT = 'marko.yml'.freeze
      SOURCE = 'src'.freeze
      BINARY = 'bin'.freeze
      SAMPLE = 'tt'.freeze
      ASSETS = File.join(BINARY, 'assets').freeze
      DEMO = File.join('.marko', 'demo').freeze
      SAMPLES = File.join('.marko', 'samples').freeze

      def marko_directories
        [SOURCE, BINARY, ASSETS, SAMPLE]
      end

      def marko_home!
        fail Failure, "Marko project required!" unless marko_home?
      end

      def backup(filename)
        cp(filename, filename + ?~) if File.exist?(filename)
      end

    end

  end
end
