desc 'Generate the screenshots'
task :screenshots do
  print 'Building screenshots... '
  require_relative 'examples/screenshots'
  print 'Extracting screenshots...'
  # Note: examples 1, 2 need to be cropped at 309, example 3 at 455
  `convert -density 175 -colorspace sRGB screenshots.pdf -resize 50% -quality 100 -crop 744x320+0+292 screenshots/%02d.png`
  puts 'DONE!'
end

task default: [:screenshots]