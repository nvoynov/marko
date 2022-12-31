# frozen_string_literal: true

require_relative "gadgets"
require_relative "config"

module Marko

  # The strategy class for loading sources from repository
  class Loader < Service
    # load markup sources, parse and return TreeNode buffer
    #
    # @example
    #   fn = proc{|event, paylod| ... }
    #   buffer, errors = loader.(&fn)
    #   fail "Failed" if errors.any?
    #   # procced ...
    #
    # @param block [&block] aka proc {|event, payload| ..}
    # @return [Array<TreeNode>, Array<String>] where
    #   the first item is buffer and the second is array<error>
    def call
      buffer = []
      errors = []
      parser = ParserPlug.plugged
      storage = StoragePlug.plugged
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
