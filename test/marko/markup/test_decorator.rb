require_relative '../../test_helper'
include Marko::Markup

class TestDecorator < Minitest::Test
  def decor(title = '', body = '', **meta)
    node = TreeNode.new(title, body, **meta)
    Decorator.new(node)
  end

  def test_url
    assert_equal '#id', decor(id: 'id').url
    assert_equal '#', decor().url
  end

  def test_ref
    # @todo trciky things with #url and #title
    assert_equal '[Title](#id)', decor('Title', id: 'id').ref
    assert_equal '[.id](#some-id)', decor(id: 'some.id').ref
    assert_equal '[.id](#id)', decor(id: 'id').ref
    assert_equal '[.id](#id)', decor(id: 'id').ref
  end

  def test_title
    assert_equal 'title', decor('title').title
    assert_equal '.id', decor(id: 'some.id').title
    assert_equal '.id', decor(id: '.id').title
    assert_equal '.id', decor(id: 'id').title
  end

  def test_header
    tree = TreeNode.new('Title')
    tree << TreeNode.new('h1', id: 'h1')
    tree.items.last << TreeNode.new('h2', id: '.h2')
    deco = tree.inject([]){|memo, i| memo << Decorator.new(i)}
    assert_equal "% Title", deco[0].header
    assert_equal "# h1 {#h1}", deco[1].header
    assert_equal "## h2 {#h1-h2}", deco[2].header
  end

  def test_meta
    m = decor(id: 'id', author: 'spec').meta
    assert m[:id]
    assert m[:author]
    m = decor(id: 'id', author: 'spec', origin: 'o', order_index: 'o').meta
    assert m[:id]
    assert m[:author]
    refute m[:origin]
    refute m[:parent]
    refute m[:order_index]
  end

  def test_props
    m = decor(id: 'id', author: 'spec', depend: 'one two three')
    # puts ?\n, m.props
    m.props
  end

  def test_body
    assert_equal '', decor('title').body
    assert_equal "body", decor('title', 'body').body

    deco = decor('title', "body @@todo subject\n")
    assert_equal "body", deco.body
  end
end
