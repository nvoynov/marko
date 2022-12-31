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

class TestMLink < Minitest::Test
  def setup
    @macro = MLink.new
  end

  def test_subs
    deco = Decorator.new(TreeNode.new('Dummy'))
    sample = '[lost](#lost-link)'
    assert_equal sample, @macro.subs('[[lost]]', deco)
  end

  def test_gsub!
    tree = TreeNode.new('Title', id: 'root')
    head = TreeNode.new('h1', 'Bla bla bla [[lost]] and [[.h2]]', id: '.h1')
    tail = TreeNode.new('h2', 'Bla bla bla and [[root.h1]]', id: '.h2')
    tree << head
    head << tail

    dhead = Decorator.new(head)
    source = dhead.body
    sample = "Bla bla bla [lost](#lost-link) and [h2](#root-h1-h2)\n"
    @macro.gsub!(source, dhead)
    assert_equal sample, source
  end
end

class TestMList < Minitest::Test
  def setup
    @macro = MList.new

    @tree = TreeNode.new('Title', 'something as follows\n@@list')
    @tree << TreeNode.new('h1', id: 'h1')
    @tree << TreeNode.new('h2', id: 'h2')
  end

  def test_subs
    deco = Decorator.new(@tree)
    sample = <<~EOF
      - [h1](#h1)
      - [h2](#h2)
    EOF
    assert_equal sample, @macro.subs('@@list', deco)
    assert_equal ?\n, @macro.subs('@@list', Decorator.new(@tree.items.first))
  end
end

class TestMTree < Minitest::Test
  def setup
    @macro = MTree.new
  end

  def tree
    subj = TreeNode.new('Title', 'something as follows\n@@list', id: '0')
    subj << TreeNode.new('h1', id: 'h1')
    subj << TreeNode.new('h2', id: 'h2')

    TreeNode.new.tap{|r| r << subj}
  end

  def test_subs
    deco = Decorator.new(tree)
    sample = <<~EOF
      - [Title](#0)
         - [h1](#h1)
         - [h2](#h2)
    EOF
    assert_equal sample, @macro.subs('@@tree', deco)
    assert_equal ?\n, @macro.subs(
      '@@tree', Decorator.new(TreeNode.new))
  end
end

class TestMTodo < Minitest::Test
  def setup
    @macro = MTodo.new
  end

  def test_subs
    assert_equal '', @macro.subs("@@todo\n")
    assert_equal '', @macro.subs("@@todo something\n")
  end

  def test_gsub!
    source = <<~EOF
      Bla-bla-bla
      @@todo something
      Bla-bla-bla @@todo another
    EOF

    sample = <<~EOF
      Bla-bla-bla
      Bla-bla-bla
    EOF

    @macro.gsub!(source)
    assert_equal sample.strip + ?\s, source
  end
end

class TestMSkip < Minitest::Test
  def setup
    @macro = MSkip.new
  end

  def test_subs
    assert_equal '', @macro.subs("@@skip")
    assert_equal '', @macro.subs("@@skip\nbla-bla-bla\n")
  end

  def test_gsub!
    source = <<~EOF
      Bla-bla-bla
      @@skip something
      this line must be skipped
      and this line also
    EOF

    @macro.gsub!(source)
    assert_equal "Bla-bla-bla\n", source
  end
end
