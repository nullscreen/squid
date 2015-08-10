# By default, <code>chart</code> uses a line width of 3 for line charts.
#
# You can use the <code>:line_width</code> option to customize this value.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 802000000000000000000}}
  chart data, type: :line, line_width: 10
end
