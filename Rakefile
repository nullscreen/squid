require 'bundler/gem_tasks'

desc 'Generate the manual'
task :manual do
  print 'Building manual... '
  require_relative 'examples/manual'
  puts 'DONE!'
end

desc 'Generate the readme'
task :readme do
  print 'Building readme... '
  require_relative 'examples/readme'
  print 'Extracting screenshots...'
  `convert -density 175 -colorspace sRGB readme.pdf -resize 50% -quality 100 -crop 744x320+0+280 examples/screenshots/readme_%02d.png`
  puts 'DONE!'
end


require "rspec/core/rake_task"
require "rspec/core/version"

desc "Run all examples"
RSpec::Core::RakeTask.new :spec

task default: [:spec]