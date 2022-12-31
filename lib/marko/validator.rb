# frozen_string_literal: true

require_relative "tree_node"

module Marko

  # The strategy of tree validation
  class Validator
    extend Pluggable

    # @param tree [TreeNode]
    # @param block [&block] proc {|event, payload|}
    # @return [Array<String>] errors array
    def call(tree, &block)
      fail "the abstract method must be overriden"
    end
  end

end
