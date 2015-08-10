# By default, <code>chart</code> is not plotted with an outer border.
#
# You can use the <code>:border</code> option to enable this behavior.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {Safari: 45.20001, Firefox: 33.3999, Chrome: 21.4}}
  chart data, border: true
end
