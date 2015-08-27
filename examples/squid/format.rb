# You can specify the format of the axis values with the <code>:format</code> option.
#
# Valid options are: <code>:percentage</code>, <code>:currency</code>, <code>:seconds</code>, <code>:float</code>.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {Safari: 45.20001, Firefox: 33.3999, Chrome: nil}}
  chart data, format: :percentage, label: true
end
