require_relative "test_helper"

# exe/marko when gem is installed, sort of dry-run
describe 'exe/marko' do
  it 'must compile|c' do
    Sandbox.() { system "marko compile" }
    Sandbox.() { system "marko c"       }
  end

  it 'must new|n' do
    Tempbox.() { system "marko new dummy" }
    Tempbox.() { system "marko n dummy"   }
  end

  it 'must demo|d' do
    Tempbox.() { system "marko demo" }
    Tempbox.() { system "marko d"    }
  end
end
