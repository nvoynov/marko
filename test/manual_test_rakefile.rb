require_relative "test_helper"

describe 'Rakefile' do

  it 'marko:mm' do
    Sandbox.() { system "rake marko:mm" }
    Sandbox.() { system "rake marko:mm[home]" }
  end

  it 'marko:toc' do
    Sandbox.() { system "rake marko:toc" }
    Sandbox.() { system "rake marko:toc[root]" }
  end

  it 'marko:publish' do
    Sandbox.() { system "rake marko:publish" }
  end

  it 'marko:todo' do
    Sandbox.() { system "rake marko:todo" }
  end

end
