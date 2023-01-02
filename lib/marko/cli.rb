# frozen_string_literal: true

require "optparse"
require_relative "services"
include Marko::Services

module Marko
  module CLI
    extend self

    def punch(dir, args = ARGV)
      if Dir.exist?(dir)
        puts "Directory '#{dir}' already exist!"
        return
      end
      storage.punch(dir)
      puts "Marko directory created!"
      log = Dir.chdir(dir) { Dir.glob('**/*') }
      puts log.map{ "  created #{dir}/#{_1}" }.join(?\n)
      kwargs = options(:new, args)
      editor = kwargs.fetch(:editor, '')
      Dir.chdir(dir) { `#{editor} .` } unless editor.empty?
    end

    def punch_demo(args = ARGV)
      # pp options(:demo, args)
      log = storage.punch_demo
      puts "Marko Demo cloned!\n#{log}"
      kwargs = options(:demo, args)
      editor = kwargs.fetch(:editor, '')
      Dir.chdir(log) { `#{editor} .` } unless editor.empty?
    end

    def compile(args = ARGV)
      unless storage.marko_home?
        puts "Marko directory required!"
        return
      end
      kwargs = options(:compile, args)
      verbose = kwargs.delete(:verbose) { false }
      pulsefn = method(verbose ? :pulse_verbose : :pulse_concise)
      result = Compile.(**kwargs, &pulsefn)
      puts "compiled #{result}\nSuccess!"
    rescue Marko::Assembler::Failure => e
      puts "Assembler failed with #{e.errors.size} #{e.message}"
      puts "Failure"
    end

    def banner
      puts "#{BANNER}\nUsage:"
      PARSER.each{|_, cmd| puts "\n  #{cmd}"}
    end

    protected

    def storage
      StoragePlug.plugged
    end

    def pulse_verbose(events, payload)
      case events
      when :stage
        puts "#{payload}.."
      when :source
        print "  #{payload}.."
      when :errors
        unless payload.empty?
          puts "#{payload.size} errors #{payload.join}"
        else
          puts "OK"
        end
      end
    end

    def pulse_concise(events, payload)
      case events
      when :stage
        puts "#{payload}.."
      end
    end

    def options(cmd, args = ARGV)
      {}.tap{|opt| PARSER[cmd].parse(args, into: opt)}
    end

    # \    ^__^
    #   \  (oo)\_______
    #      (__)\       )\/\
    #          ||----w |
    #          ||     ||
    BANNER = <<~EOF.freeze
      \s    ^__^
      \s    (oo)\_______
      \s    (__)\       )\/\\
      \s  ~ Marko v0.1.3 ~ aka markup compiler
      \s  home https://github.io/nvoynov/marko
    EOF

    PARSER = {
      new: OptionParser.new {|cmd|
        ban = "marko new|n DIRECTORY [OPTIONS]".ljust(35, ?\s)
        cmd.banner = ban + "Create a new Marko project"
        cmd.on('-e EDITOR', '--editor EDITOR',
          'Open the project in EDITOR', String)
      },
      demo: OptionParser.new {|cmd|
        ban = "marko demo|d [OPTIONS]".ljust(35, ?\s)
        cmd.banner = ban + "Clone Marko Demo project"
        cmd.on('-e EDITOR', '--editor EDITOR',
          'Open the project in EDITOR', String)
      },
      compile: OptionParser.new {|cmd|
        ban = "marko compile|c [OPTIONS]".ljust(35, ?\s)
        cmd.banner = ban + "Compile Marko artifact"
        cmd.on('-t TEMPLATE', '--template TEMPLATE',
          'Template to render', String)
        cmd.on('-o FILENAME', '--filename FILENAME',
          'Render to filename', String)
        cmd.on('-v', '--verbose', 'Run verbosely')
      }
    }.freeze

  end
end
