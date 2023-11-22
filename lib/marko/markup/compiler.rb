# frozen_string_literal: true

require "erb"
require_relative "../compiler"
require_relative "../config"

module Marko
  module Markup

    class Compiler < Marko::Compiler

      # @see Marko::Compliler#call
      def call(tree, template, filename, &block)
        super(tree, template, filename, &block)
        compile
      end

      protected

      def compile
        storage = StoragePlug.plugged
        @model = @tree.map{|n| Markup::Decorator.new(n)}
        samplr = ERB.new(@template, trim_mode: '%<>')
        storage.write(@filename, samplr.result(binding))
        @filename
      end
    end

  end
end
