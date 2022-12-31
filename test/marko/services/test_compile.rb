require_relative "../../test_helper"
include Marko::Services

describe Compile do
  # initialize(tree: nil, template: '', filename: '', &block)
  let(:service) { Compile }

  it 'must fail for wrong arguments' do
    assert_raises(ArgumentError) { service.(tree: 42) }
    assert_raises(ArgumentError) { service.(template: 42) }
    assert_raises(ArgumentError) { service.(filename: 42) }
  end

  let(:proper) {
    <<~EOF
    # a
    body
    # b
    body
    EOF
  }
  # it will fail Assembler::Failure that is enough
  # let(:faulty) {}

  let(:tree) {
    TreeNode.new('Title').tap{|root|
      root << TreeNode.new('a', 'some content', id: a)
      root << TreeNode.new('a', 'some content', id: b)
    }
  }

  it 'must assemble tree itself' do
    Sandbox.() {
      File.write('src/proper.md', proper)
      service.()
      assert File.exist?(Marko.artifact.filename)
    }
  end

  it 'must accept tree argument' do
    Sandbox.() {
      File.write('src/proper.md', proper)
      tree = Assembler.()
      service.(tree: tree)
      assert File.exist?(Marko.artifact.filename)
    }
  end

  it 'must pass the &block to assembler' do
    log = []; fn = proc{|event, payload| log << [event, payload]}
    Sandbox.() {
      File.write('src/proper.md', proper)
      service.(&fn)
      refute log.empty?
    }
  end
end
