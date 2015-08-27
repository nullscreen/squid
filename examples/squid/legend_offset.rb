# By default, <code>chart</code> adds a legend in the top-right corner.
#
# You can use the <code>:legend</code> option to change the position of the legend.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46}, uniques: {2013 => 94, 2014 => 27}}
  chart data, legend: {right: 50}
end
