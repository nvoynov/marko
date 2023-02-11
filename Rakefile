# frozen_string_literal: true

# require "rake"
# require "sancho"
# tasks, folders = Sancho.tasks
# Rake.application.rake_require tasks, folders

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

task default: :test
