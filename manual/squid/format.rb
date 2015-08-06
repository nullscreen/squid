# By default, <code>chart</code> prints the axis values as unformatted numbers.
#
# You can pick a different format with the <code>:format</code>.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {Safari: 45.20001, Firefox: 33.3999, Chrome: 21.4}}
  chart data, format: :percentage
end
