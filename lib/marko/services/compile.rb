require_relative "../gadgets"
require_relative "../assembler"

module Marko
  module Services

    # Compitation service
    class Compile < Service
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
        storage = StoragePlug.plugged
        compiler = CompilerPlug.plugged
        erb = storage.content(@template)
        @tree = Assembler.(&@block) unless @tree
        compiler.(@tree, erb, @filename, &@block) # => filename
      end
    end

  end
end
