require_relative '../../test_helper'
include Marko::Markup

class TestTheSameId < Minitest::Test
  def inspector
    TheSameId.new
  end

  def test_call
    # :origin, :lineno, :markup
    orig = Parser::Origin.new('src/source1.md', 1, '# a')
    tree = TreeNode.new('Title').tap{|root|
      root << TreeNode.new('a', id: 'a', origin: orig)
      root << TreeNode.new('b', id: 'b')
    }
    assert_equal [], inspector.(tree)

    orig = Parser::Origin.new('src/source2.md', 1, '# c')
    tree << TreeNode.new('c', id: 'a', origin: orig)
    assert_equal 1, inspector.(tree).size
  end
end

class TestLostParent < Minitest::Test
  def inspector
    LostParent.new
  end

  def test_call
    # :origin, :lineno, :markup
    orig = Parser::Origin.new('src/source1.md', 1, '# a')
    tree = TreeNode.new('Title').tap{|root|
      root << TreeNode.new('a', id: 'a', origin: orig)
      root << TreeNode.new('b', id: 'b')
    }
    assert_equal [], inspector.(tree)

    orig = Parser::Origin.new('src/source2.md', 1, '# c')
    tree << TreeNode.new('c', parent: 'e', origin: orig)
    assert_equal 1, inspector.(tree).size
    # pp inspector.(tree)
  end
end

class TestLostIndex < Minitest::Test
  def inspector
    LostIndex.new
  end

  def test_call
    # :origin, :lineno, :markup
    orig = Parser::Origin.new('src/source1.md', 1, '# a')
    tree = TreeNode.new('Title', order_index: 'a b').tap{|root|
      root << TreeNode.new('a', id: 'a', origin: orig)
      root << TreeNode.new('b', id: 'b')
    }
    assert_equal [], inspector.(tree)

    orig = Parser::Origin.new('src/source2.md', 1, '# c')
    tree << TreeNode.new('c', order_index: 'a b', origin: orig)
    tree.items.last << TreeNode.new('a', id: 'a', origin: orig)
    tree << TreeNode.new('d', order_index: 'a b', origin: orig)
    assert_equal 2, inspector.(tree).size
    # pp inspector.(tree)
  end
end

class TestLostLink < Minitest::Test
  def inspector
    LostLink.new
  end

  def test_call
    # :origin, :lineno, :markup
    orig = Parser::Origin.new('src/source1.md', 1, '# Title')
    tree = TreeNode.new('Title', id: 'root')
    assert_equal [], inspector.(tree)

    tree << TreeNode.new("a", "bla-bla-bla [[root]]", origin: orig)
    assert_equal [], inspector.(tree)

    tree << TreeNode.new("b", "bla-bla-bla [[lost]] and [[wrong]]", origin: orig)
    tree << TreeNode.new("c", "bla-bla-bla [[lost]]", origin: orig)
    assert_equal 2, inspector.(tree).size
  end
end
