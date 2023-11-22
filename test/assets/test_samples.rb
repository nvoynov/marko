require_relative "../test_helper"

class Sampler
  def self.call(model, sample)
    new.(model, sample)
  end

  def call(model, sample)
    @model = model.map{|n| Markup::Decorator.new(n)}
    samplr = ERB.new(sample, trim_mode: '%<>')
    samplr.result(binding)
  end
end

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

  def samples
    dir = './lib/assets/init/tt'
    Dir.glob("#{dir}/*.md.tt")
      .map{ File.read(_1) }
  end

  def nodes
    [some_tree, just_root]
  end

  def test_dry_run
    nodes.product(samples).each{|tree, sample|
      # puts Sampler.(tree, sample)
      Sampler.(tree, sample)
    }
  end
end
