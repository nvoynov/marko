# frozen_string_literal: true

require_relative "marko/version"
require_relative "marko/gadgets"
require_relative "marko/tree_node"
require_relative "marko/storage"
require_relative "marko/parser"
require_relative "marko/loader"
require_relative "marko/validator"
require_relative "marko/assembler"
require_relative "marko/compiler"
require_relative "marko/services"
require_relative "marko/config"
require_relative "marko/markup"
require_relative "marko/cli"

module Marko
  # class Error < StandardError; end

  class << self
    def root
      File.dirname __dir__
    end
  end
end
