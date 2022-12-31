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

      # create demo project
      def punch_demo
        demo = File.join(Dir.home, DEMO)
        unless Dir.exist?(demo)
          punch(demo)
          assets = File.join(Marko.root, 'lib', 'assets', 'demo', '.')
          cp_r assets, demo
        end
        demo
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
      DEMO = 'marko_demo'.freeze

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
