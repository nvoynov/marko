require_relative "../test_helper"

# @todo the same dilema as for test_loader
# @todo and mix DLS with Test in one file,
#   maybe DSL should be placed under markup/test_assembler?
describe Assembler do

  let(:assembler) { Assembler }

  # @todo it seems much reasonable, although dirtier, to test it
  #   inside Sandbox with Markup::Parser and Markup::Storage
  #   maybe it should be moved under marko/markup?
  let(:proper) {
    <<~EOF
      # Intro
      ## Purpose
      ## Overview
      # Use Cases
      {{id: uc}}
      # UC01
      {{parent: uc}}
    EOF
  }

  let(:faulty_markup) {
    <<~EOF
      % Title
      ## a
    EOF
  }

  let(:faulty_tree) {
    <<~EOF
      # User Stories
      ##
      I want one [[lost]]
    EOF
  }

  describe '#call' do
    it 'must return Artifact for no sources found' do
      Sandbox.() {
        tree = assembler.()
        assert tree
        assert_kind_of TreeNode, tree
        assert_equal 0, tree.items.size
      }
    end

    it 'must assemble tree' do
      Sandbox.() {
        File.write('src/proper.md', proper)
        tree = assembler.()
        assert_equal 2, tree.items.size
      }
    end

    it 'must callback when &block given' do
      log = []; fn = proc{|event, payload| log << [event, payload]}
      Sandbox.() {
        assembler.(&fn)
        assert_equal "loading sources", log[0][1]
        assert_equal "tree assemblage", log[1][1]
        assert_equal "tree enrichment", log[2][1]
        assert_equal "tree validation", log[3][1]
      }
    end

    it 'must fail on sources parsing errors' do
      Sandbox.() {
        File.write('src/faulty_markup.md', faulty_markup)
        ex = assert_raises(Assembler::Failure) { assembler.() }
        assert_match %r{markup parsing failed}, ex.message
        assert_match %r{wrong markup}, ex.message
        assert_match %r{wrong header}, ex.message
      }
    end

    it 'must fail on tree validation errors' do
      Sandbox.() {
        File.write('src/proper.md', proper)
        File.write('src/faulty_tree.md', faulty_tree)
        ex = assert_raises(Assembler::Failure) { assembler.() }
        assert_match %r{tree validation failed}, ex.message
        assert_match %r{lost link}, ex.message
      }
    end
  end
end

class Assembler
  public_class_method :new
  public :load, :assemble, :injectid, :validate
end

class TestAssembler < Minitest::Test

  def assembler
    Assembler.new
  end

  def load_sample
      [
        TreeNode.new('a', id: 'a').tap{|root|
          root << TreeNode.new('a1')
          root << TreeNode.new('a2')
        },
        TreeNode.new('b', id: 'b').tap{|root|
          root << TreeNode.new('b1')
        },
        TreeNode.new('b2', parent: 'b'),
        TreeNode.new('e', parent: 'lost')
      ]
  end

  def test_failure
    msg = "errors"
    err = ['error source.md:01', 'error source.md:02']
    failure = Assembler::Failure.new(msg)
    assert_equal msg, failure.message
    failure = Assembler::Failure.new(msg, *err)
    assert_match %r{error source.md:01}, failure.message
    assert_match %r{error source.md:02}, failure.message
  end

  def test_assemble
    tree = assembler.assemble(load_sample)
    assert_equal 3, tree.items.size
  end

  def test_injectid
    assm = assembler
    tree = assm.assemble(load_sample)
    assm.injectid(tree)

    assert tree.find_node('a.01')
    assert tree.find_node('a.02')
    assert tree.find_node('b.01')
    assert tree.find_node('b.02')
    assert tree.find_node('01')
  end

end
