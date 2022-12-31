require "forwardable"
require_relative "../gadgets"
require_relative "../assembler"

module Marko
  module Services

    class Compile < Service
      extend Forwardable
      def_delegator :StoragePlug, :plugged, :storage
      def_delegator :CompilerPlug, :plugged, :compiler

      def initialize(tree: nil, template: '', filename: '', &block)
        @tree = MustbeTreeNode.(tree) if tree
        @template = MustbeString.(template)
        @filename = MustbeString.(filename)
        @block = block

        art = Marko.artifact
        @template = art.template if @template.empty?
        @filename = art.filename if @filename.empty?
      end

      def call
        erb = storage.content(@template)
        @tree = Assembler.(&@block) unless @tree
        compiler.(@tree, erb, @filename, &@block) # => filename
      end
    end

  end
end
