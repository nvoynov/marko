require_relative "../test_helper"

describe Loader do
  let(:loader) { Loader }

  # @todo it seems much reasonable, although dirtier, to test it
  #   inside Sandbox with Markup::Parser and Markup::Storage
  #   maybe it should be moved under marko/markup?
  let(:proper) {
    <<~EOF
      # a
      # b
    EOF
  }

  let(:faulty) {
    <<~EOF
      % title
      ## a
      # b
      ## c
      #### d
    EOF
  }

  describe '#call' do
    it 'must return [array, array]' do
      Sandbox.() {
        assert_equal [[], []], loader.()

        File.write('src/proper.md', proper)
        buffer, errors = loader.()
        assert_equal 2, buffer.size
        assert_equal [], errors

        File.write('src/faulty.md', faulty)
        buffer, errors = loader.()
        assert_equal 5, buffer.size
        assert_equal 3, errors.size
      }
    end

    it 'must callback with :source and :error when &block given' do
      Sandbox.() {
        log = []; fn = proc{|event, payload| log << [event, payload]}
        loader.(&fn)
        assert_equal [], log

        File.write('src/proper.md', proper)
        loader.(&fn)
        assert_equal [:source, 'src/proper.md'], log[0]
        assert_equal [:errors, []], log[1]

        log.clear
        File.write('src/faulty.md', faulty)
        loader.(&fn)
        assert_equal 4, log.size
        proper_index = log.index{|i| i[1] == 'src/proper.md'}
        faulty_index = log.index{|i| i[1] == 'src/faulty.md'}
        assert proper_index
        assert faulty_index
        assert_equal 0, log.at(proper_index + 1)[1].size
        assert_equal 3, log.at(faulty_index + 1)[1].size
      }
    end
  end
end
