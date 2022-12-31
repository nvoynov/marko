require_relative "../gadgets"
require_relative "../assembler"

module Marko
  module Services

    # Assemblage service
    # @todo assemble projects bu url
    class Assemble < Service
      def call
        Assembler.(&@block)
      end
    end

  end
end
