# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require_relative "../lib/marko"
include Marko

require "minitest/autorun"

class Tempbox
  # Execute block inside temp folder
  def self.call
    Dir.mktmpdir([TMPRX]) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
  TMPRX = 'markobox'.freeze
end

class Sandbox
  def self.call
    Dir.mktmpdir([TMPRX]) do |dir|
      Dir.chdir(dir) do
        storage = StoragePlug.plugged
        storage.punch(DUMMY)
        Dir.chdir(DUMMY){ yield }
      end
    end
  end

  TMPRX = 'marko'.freeze
  DUMMY = 'dummy'.freeze
end

class StubMarkupStorage
  def self.storage_klass
    Class.new(Storage) do
      def initialize(*payload)
        print "\ndebug>> StubMarkupStorage payload:"; pp payload
        @payload = payload
      end
      def sources
        @payload
          .each_with_index{|_, i| "source#{i}.md"}.map
      end

      def content(source)
        @payload[source.scan(/\d/).first.to_i]
      end
    end
  end

  def self.call(*payload)
    storage = storage_klass.new(*payload)
    origin = StoragePlug.plugged
    StoragePlug.plugged = storage
    # ParserPlug.plugged = MarkupParser.new
    yield if block_given?
    StoragePlug.plugged = origin
  end
end

def print_tree(tree)
  head, *tail = tree.inject([], :<<)
  puts "\n% #{head.title}"
  puts tail.map{|n|
    puts '#' * n.nesting_level + " [#{n.id}] " + n.title
  }.join(?\n)
end

def punch_sample(sample)
  filename = File.join(Marko.root, 'test', 'samples', sample)
  File.write("src/#{sample}", File.read(filename))
end
