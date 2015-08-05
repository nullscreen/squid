# By default, <code>chart</code> plots 5 equidistant horizontal gridlines.
# You can use the <code>:gridlines</code> option to change this number.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 102}}
  text 'With 2 gridlines:'
  chart data, gridlines: 2
end
