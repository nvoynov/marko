require_relative "../../test_helper"
include Marko::Markup

class Marko::Markup::Parser
  public :parse, :scan_treenode, :find_parent
  public :parse_treenode, :parse_metadata, :parse_attribute
end

class TestParser < Minitest::Test
  def parser
    Parser.new
  end

  def test_origin
    orig = Parser::Origin.new('src/source.md', 1, '# title')
    assert_equal 'src/source.md', orig.origin
    assert_equal '# title', orig.markup
    assert_equal 1, orig.lineno
    assert_equal '# title', orig.header
    assert_equal 1, orig.level
    assert_equal "src/source.md:01 >> # title", orig.to_s
  end

  def test_scan_treenode
    content = <<~EOF
      % Title
      # Node 1
      bla-bla-bla
      ## Node 2
      ### Node 3
      ##### Node 5
    EOF
    sample = [
      "% Title\n",
      "# Node 1\nbla-bla-bla\n",
      "## Node 2\n",
      "### Node 3\n",
      "##### Node 5\n"
    ]
    assert_equal sample, parser.scan_treenode(content).map{_1.markup}
  end

  def test_parse_attribute
    assert_equal [:id, '.id'], parser.parse_attribute('id: .id')
    assert_equal [:approved, 'true'], parser.parse_attribute('approved:')
    assert_equal [:approved, 'true'], parser.parse_attribute('approved')
    assert_raises(StandardError) { parser.parse_attribute(nil) }
    assert_raises(StandardError) { parser.parse_attribute('') }
  end

  def test_parse_metadata
    assert_equal({}, parser.parse_metadata(''))
    txt = 'id: i1, parent: root'
    hsh = {id: 'i1', parent: 'root'}
    assert_equal hsh, parser.parse_metadata(txt)

    # multiline
    hsh = {id: 'i1', parent: 'root'}
    samples = [
      'id: i1, parent: root',
      'id: i1; parent: root',
      "\nid: i1, parent: root",
      "id: i1, parent: root\n",
      "\nid: i1, parent: root\n",
      "\nid: i1, \nparent: root\n",
      "id: i1\nparent: root"
    ]
    samples.each{|txt| assert_equal hsh, parser.parse_metadata(txt) }
  end

  def test_parse_treenode
    n = parser.parse_treenode('#')
    assert_equal '', n.id
    assert_equal '', n.title
    assert_equal '', n.body

    n = parser.parse_treenode('# title')
    assert_equal '', n.id
    assert_equal 'title', n.title
    assert_equal '', n.body

    n = parser.parse_treenode("## title\n{{id: id, parent: 0}}\n\nbody1\nbody2")
    assert_equal 'id', n.id
    assert_equal 'title', n.title
    assert_equal Hash[id: 'id', parent: '0'], n.meta
    assert_equal "body1\nbody2", n.body
  end

  def test_find_parent
    content = <<~EOF
      ## h2

      # h1
      body

      ## h2
      body

      #### h4
    EOF

    target = []
    assert_equal target, parser.find_parent(target, 1)

    source = parser
      .scan_treenode(content)
      .map{|orig|
        parser
          .parse_treenode(orig.markup)
          .tap{|n| n[:origin] = orig}
      }

    assert_nil parser.find_parent(target, 2)
    target << source.shift
    target << source.shift

    assert_equal target.last, parser.find_parent(target, 2)
    target.last << source.shift
    assert_nil parser.find_parent(target, 4)
  end

  def test_parse
    content = <<~EOF
      ## h2

      # h1
      body

      ## h2
      body

      #### h4
    EOF
    result, errors = parser.(content, 'spec')
    assert_equal 3, result.size
    assert_equal 2, errors.size

    assert_equal Array[[], []], parser.("", 'spec')
    result, errors = parser.("something strange {{}}", 'spec')
    assert_empty result
    refute_empty errors
  end

end
