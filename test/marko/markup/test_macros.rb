require_relative '../../test_helper'
include Marko::Markup

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

    @tree = TreeNode.new('Title',
      "something as follows\n@@list")
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

  def test_gsub
    deco = Decorator.new(@tree)
    sample = <<~EOF
      - [h1](#h1)
      - [h2](#h2)
    EOF
    assert deco.body.end_with?(sample)
  end
end

class TestMTree < Minitest::Test
  def setup
    @macro = MTree.new
  end

  def tree
    subj = TreeNode.new('Title', id: '0')
    subj << TreeNode.new('h1', id: 'h1')
    subj << TreeNode.new('h2', id: 'h2')
    TreeNode.new('sample', "@@tree").tap{|r| r << subj}
  end

  def test_subs
    deco = Decorator.new(tree)
    sample = <<~EOF
      - [Title](#0)
         - [h1](#h1)
         - [h2](#h2)
    EOF
    assert_equal ?\n, @macro.subs(
      '@@tree', Decorator.new(TreeNode.new))
    assert_equal sample, @macro.subs('@@tree', deco)
    assert deco.body.end_with?(sample)
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

class TestMTodo < Minitest::Test
  def setup
    @macro = MTodo.new
  end

  def test_subs
    assert_equal '', @macro.subs("@@todo")
    assert_equal '', @macro.subs("@@todo something")
    assert_equal ?\n, @macro.subs("@@todo something\n")
    assert_equal "line\n", @macro.subs("line @@todo something\n")
  end

  def test_gsub!
    source = <<~EOF
      line1
      @@todo sth.
      line2 @@todo sth.
      line3
    EOF

    sample = <<~EOF
      line1

      line2
      line3
    EOF
    @macro.gsub!(source)
    assert_equal sample, source
  end
end
