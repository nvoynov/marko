require_relative '../../test_helper'
include Marko::Markup

class TestCompiler < Minitest::Test
  def compiler
    Compiler.new
  end

  def template
    name = File.join(Marko.root, 'lib', 'assets', 'init', 'tt', 'artifact.md.tt')
    File.read(name)
  end

  def tree
    TreeNode.new('Title').tap{|root|
      root << TreeNode.new('Introduction')
      root.items.last << TreeNode.new('Purpose', id: '01')
      root.items.last << TreeNode.new('Overview', id: '02')

      root << TreeNode.new('Users', id: 'usr')
      root << TreeNode.new('User Requirements')
      root.items.last << TreeNode.new('User Stories', id: 'us')
      root.items.last << TreeNode.new('Use Cases', id: 'uc')

      uc = root.find_node('uc')
      body = <<~EOF
        As an author who works on artifact, I want to scan the sources for \@\@todo macro and get the list of node references and those macro text, so that I can have some focus
      EOF
      uc << TreeNode.new("", body, id: '.01')
      body = <<~EOF
        As an author who works on artifact, I want to have something like [[uc.01]]...
      EOF
      uc << TreeNode.new("", body, id: '.02')
    }
  end

  def mock_storage
    Class.new(Storage) do
      attr_reader :fake_write_body
      def write(filename, content = '', &block)
        @fake_write_body = StringIO.new
        @fake_write_body.puts content unless content.empty?
        yield(@fake_write_body) if block_given?
      end
    end
  end

  def test_call
    storage = mock_storage.new
    StoragePlug.stub :plugged, storage do
      res = compiler.(tree, template, 'artifact.md')
      assert_equal 'artifact.md', res
      refute_empty storage.fake_write_body.string
    end
  end


end
