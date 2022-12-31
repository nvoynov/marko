# frozen_string_literal: true

module Marko
  # Pluggable mixin serves for dependency injection
  #
  # @example
  #   class Storage
  #     extend Pluggable
  #     def call
  #     end
  #   end
  #
  #   StoragePort = Storage.port
  #
  #   class SequelStorage < Storage
  #   end
  #
  #   StoragePort.plugged = SequelStorage.new
  #
  #   require 'forwardable'
  #   class Service
  #     extend Forwardable
  #     def_delegator :StoragePort, :plugged, :storage
  #     def call
  #       storage.call
  #     end
  #   end
  module Pluggable

    def plug
      klass = self
      Module.new {
        extend Plug;
        plug klass
      }
    end

    module Plug
      def plug(klass)
        @klass = klass
      end

      def plugged
        fail "unknown @klass" unless @klass
        @plugged ||= @klass.new
      end

      def plugged=(obj)
        fail ArgumentError.new("required an instance of #{@klass}"
        ) unless obj.is_a?(@klass)
        @plugged = obj
      end
    end
  end
end
