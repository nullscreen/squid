require 'bundler/gem_tasks'

desc 'Generate the manual'
task :manual do
  print 'Building manual... '
  require_relative 'manual/contents'
  puts 'DONE!'
end


require "rspec/core/rake_task"
require "rspec/core/version"

desc "Run all examples"
RSpec::Core::RakeTask.new :spec

task default: [:spec]