require_relative "../../test_helper"
include Marko::Markup

class Storage
  public :marko_home?
  public :marko_home!
end

class TestStorage < Minitest::Test
  def storage
    StoragePlug.plugged
  end

  def test_marko_home?
    Tempbox.() { refute storage.marko_home? }
    Sandbox.() { assert storage.marko_home? }
  end

  def test_marko_home!
    Sandbox.() { storage.marko_home! }
    Tempbox.() do
      assert_raises(Storage::Failure) { storage.marko_home! }
    end
  end

  def test_punch
    Tempbox.() do
      storage.punch('spec')
      Dir.chdir('spec') { assert storage.marko_home? }
    end
  end

  def test_sources
    Sandbox.() {
      s1 = File.join(Storage::SOURCE, 'source1.md')
      s2 = File.join(Storage::SOURCE, 'source2.md')
      File.write(s1, '')
      File.write(s2, '')
      assert_equal [s1, s2], storage.sources
    }
  end

  def test_content
    Sandbox.() {
      source = File.join(Storage::SOURCE, 'source.md')
      File.write(source, 'content')
      assert_equal 'content', storage.content(source)
    }
  end

end
