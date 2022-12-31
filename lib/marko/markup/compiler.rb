# frozen_string_literal: true

require "forwardable"
require "erb"
require_relative "../compiler"

module Marko
  module Markup

    class Compiler < Marko::Compiler
      extend Forwardable
      def_delegator :StoragePlug, :plugged, :storage

      # @see Marko::Compliler#call
      def call(tree, template, filename, &block)
        super(tree, template, filename, &block)
        compile
      end

      protected

      def compile
        erbgen = ERB.new(@template, trim_mode: '-')
        payload = @tree.map{|n| Decorator.new(n)}
        storage.write(@filename){|f|
          payload.each{|node|
            @node = node
            text = erbgen.result(binding)
            f.puts text
          }
        }
        @filename
      end

    end

  end
end
