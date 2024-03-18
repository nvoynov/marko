# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "sancho"
source, folders = Sancho.tasks
Rake.application.rake_require source, folders

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

task default: :test

desc 'compile demo artifact'
task :mkdemo do
  Dir.mktmpdir do |dir|
    Dir.chdir(dir) do
      `marko new demo`
      Dir.chdir('demo') do
        `marko demo`
        cp_r '.marko/demo/.', '.'
        `marko c -t tt/default.md.tt`
        cp 'bin/artifact.md', File.join(__dir__, 'DEMO.md')
      end
    end
  end
end
