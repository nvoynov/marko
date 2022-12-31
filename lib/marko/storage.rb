# frozen_string_literal: true

require_relative "gadgets"

module Marko

  # The base class that represents sources repository
  class Storage
    extend Pluggable

    # create a new repository
    # @param repository [String] the name for the repository
    def punch(repository)
      fail "the abstract method must be overriden"
    end

    # @retrun [Array<String>] array of sources inside the repository
    def sources
      fail "the abstract method must be overriden"
    end

    # @param source [Striing] source to retrieve content
    # @return [String] content of :source
    def content(source)
      fail "the abstract method must be overriden"
    end

    def template(name)
      fail "the abstract method must be overriden"
    end
  end

end
