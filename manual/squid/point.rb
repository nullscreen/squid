# By default, <code>chart</code> plots a column chart.
#
# You can use the <code>:type</code> option to plot a point chart instead.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {Safari: 45.20001, Firefox: 33.3999, Chrome: 21.4}}
  chart data, type: :point
end
