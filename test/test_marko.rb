# frozen_string_literal: true

require_relative "test_helper"

class TestMarko < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Marko::VERSION
  end

  def test_assemble
    Sandbox.() { Marko.assemble }
  end

  def test_compile
    Sandbox.() { Marko.compile }
  end

end
