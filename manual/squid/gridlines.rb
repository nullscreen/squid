# By default, <code>chart</code> plots 5 equidistant horizontal gridlines.
#
# You can use the <code>:steps</code> option to change this number.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182000, 2014 => -46000, 2015 => 102000}}
  chart data, steps: 5
end
