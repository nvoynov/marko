require_relative '../test_helper'

class TestTreeNode < Minitest::Test
  def test_add # <<
    a, b = TreeNode.new, TreeNode.new
    refute b.parent
    assert_equal [], a.items
    a << b
    assert b.parent
    assert_equal [b], a.items
  end

  def test_items
    r = TreeNode.new
    a = TreeNode.new(id: 'a')
    b = TreeNode.new(id: 'b')
    c = TreeNode.new(id: 'c')
    r << a; r << b; r << c

    assert_equal [a, b, c], r.items

    r[:order_index] = 'c b a'
    assert_equal [c, b, a], r.items

    r[:order_index] = 'lost c a b'
    assert_equal [c, a, b], r.items
  end

  def test_each
    r = TreeNode.new(order_index: 'c b a')
    a = TreeNode.new(id: 'a')
    b = TreeNode.new(id: 'b')
    c = TreeNode.new(id: 'c')
    r << a; r << b; r << c

    ary = r.inject([], :<<)
    assert_equal 4, ary.size
    assert_equal [r, c, b, a], ary
  end

  # @todo add missed tests
  def test_root
    a, b = TreeNode.new, TreeNode.new
    a << b

    assert a.root?
    refute b.root?
  end
end
