# By default, <code>chart</code> does not write value labels on the chart.
#
# You can use the <code>:label</code> option to enable this behavior.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {'A very long label to test padding with labels' => {2013 => 182000, 2014 => -182000, 2015 => 182000}}
  chart data, label: true
end
