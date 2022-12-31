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
    assert_equal '[Title](#id)', decor('Title', id: 'id').ref
    assert_equal '[.id](#some-id)', decor(id: 'some.id').ref
    assert_equal '[.id](#id)', decor(id: '.id').ref # @todo is it correct behaviour?
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
    assert_equal "% Title\n", deco[0].header
    assert_equal "# h1 {#h1}\n", deco[1].header
    assert_equal "## h2 {#h1-h2}\n", deco[2].header
  end

  def test_meta
    sample = "key | value\n--- | -----\nid | id\nauthor | spec\n"
    assert_equal sample, decor(id: 'id', author: 'spec').meta
    sample = "key | value\n--- | -----\nid | id\n"
    assert_equal sample, decor(id: 'id').meta
  end

  def test_body
    assert_equal ?\n, decor('title').body
    assert_equal "body\n", decor('title', 'body').body

    deco = decor('title', "body @@todo subject\n")
    assert_equal "body\n", deco.body
  end

end
