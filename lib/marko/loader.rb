# frozen_string_literal: true

require "forwardable"
require_relative "gadgets"

module Marko

  # The strategy class for loading sources from repository
  class Loader < Service
    extend Pluggable
    extend Forwardable
    def_delegator :StoragePlug, :plugged, :storage
    def_delegator :ParserPlug, :plugged, :parser

    # load markup sources, parse and return TreeNode buffer
    #
    # @example
    #   fn = proc{|event, paylod| ... }
    #   buffer, errors = loader.(&fn)
    #   fail "Failed" if errors.any?
    #   # procced ...
    #
    # @param block [&block] aka proc {|event, payload|}
    #   for each source the method will callback
    #   (:source, "source name")
    #   (:errors, [error messages])
    # @return [Array<TreeNode>, Array<String>] where
    #   the first item is buffer and the second is array<error>
    def call
      buffer = []
      errors = []
      storage.sources.each do |source|
        @block.(:source, source) if @block
        content = storage.content(source)
        buff, errs = parser.(content, source, &@block)
        buffer.concat(buff)
        errors.concat(errs)
        @block.(:errors, errs) if @block
      end
      [buffer.flatten, errors]
    end
  end

end
