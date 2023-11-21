require_relative "../test_helper"

class TestSamples < Minitest::Test
  def just_root
    TreeNode.new('root')
  end

  def some_tree
    TreeNode.new('Title', id: 'u', depend: 'a b c').tap{|root|
      root << TreeNode.new('Topic A', id: '.a')
      root << TreeNode.new('Topic B', id: '.b')
    }
  end

  def erbs
    dir = './lib/assets/init/tt'
    Dir.glob("#{dir}/*.md.tt")
      .map{ File.read(_1) }
      .map{ ERB.new(_1, trim_mode: '%<>') }
  end

  def decor = Markup::Decorator

  def nodes
    [some_tree, just_root].map{ decor.new(_1) }
  end

  def test_dry_run
    nodes.product(erbs).each{|tree, sample|
      @node = tree
      # puts sample.result(binding)
      sample.result(binding)
    }
  end
end
