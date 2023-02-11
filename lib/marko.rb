# frozen_string_literal: true

require_relative "marko/version"
require_relative "marko/gadgets"
require_relative "marko/tree_node"
require_relative "marko/storage"
require_relative "marko/parser"
require_relative "marko/validator"
require_relative "marko/assembler"
require_relative "marko/compiler"
require_relative "marko/config"
require_relative "marko/markup"
require_relative "marko/services"
require_relative "marko/loader"
require_relative "marko/cli"

module Marko

  class << self
    def root
      File.dirname __dir__
    end

    def demo
      File.join(root, 'lib', 'assets', 'demo')
    end

    def samples
      File.join(root, 'lib', 'assets', 'samples')
    end

    # helper method for assemblage
    # @see Marko::Services::Assemble
    def assemble(&block)
      Services::Assemble.(&block)
    end

    # helper method for compilation
    # @see Marko::Services::Compile
    def compile(tree: nil, template: '', filename: '', &block)
      Services::Compile.(
        tree: tree, template: template, filename: filename, &block)
    end
  end
end
