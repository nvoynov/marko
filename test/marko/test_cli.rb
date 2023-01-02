require_relative "../test_helper"

describe CLI do
  describe '#new' do
    it 'must create marko project' do
      Tempbox.() {
        o, _ = capture_io { CLI.punch('dummy') }
        assert_match %r{created}, o

        o, _ = capture_io { CLI.punch('dummy') }
        refute_match %r{created}, o
        assert_match %r{already exist}, o
      }
    end
  end

  describe '#demo' do
    it 'must clone assets/demo' do
      Tempbox.() {
        o, _ = capture_io { CLI.punch_demo }
        demo = File.join(Dir.home, 'marko_demo')
        assert Dir.exist?(demo)
        assert_match %r{demo}, o
      }
    end
  end

  describe '#compile' do

    it 'must require Marko project' do
      Tempbox.() {
        o, _ = capture_io { CLI.compile([]) }
        assert_match %r{Marko directory required}, o
      }
    end

    it 'must compile concise/verbose' do
      Sandbox.() {
        punch_sample('proper.md')
        capture_io {
          CLI.compile([])
          CLI.compile(%w(-v))
        }
      }
    end
  end
end
