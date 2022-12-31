# frozen_string_literal: true

require_relative "gadgets"

module Marko

  # The class for pasing content into TreeNode
  class Parser
    extend Pluggable

    # @param content [String] content to parse
    # @param source [String] content source
    # @return [Array<TreeNode>, Array<String>] parsed nodes, errors
    def call(content, source, &block)
      fail "the abstract method must be overriden"
    end
  end

end
