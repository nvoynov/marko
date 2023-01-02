require_relative '../../test_helper'
include Marko::Markup

class TestMacro < Minitest::Test
  def test_gsub!
    assert_raises(StandardError) {
      Macro.new.gsub!('nonsense')
    }

    klass = Class.new(Macro) do
      @pattern = /@@foo/
      def subs(sample, obj = nil)
        '@@bar'
      end
    end

    dummy = klass.new
    source = 'bla bla @@foo bla bla @@foo'
    sample = 'bla bla @@bar bla bla @@bar'
    dummy.gsub!(source)
    assert_equal sample, source
  end
end
