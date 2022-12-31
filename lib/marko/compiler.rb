# frozen_string_literal: true

require_relative "tree_node"
require_relative "gadgets"

module Marko
  class Compiler
    extend Pluggable
    def call(tree, template, filename, &block)
      @tree = MustbeTreeNode.(tree)
      @template = MustbeString.(template)
      @filename = MustbeString.(filename)
      @block = block
    end
  end
end
