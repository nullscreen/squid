# By default, ..
#
# You can use ..
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {'Earnings' => {'2011' => 52, '2012' => 71, '2013' => 93, '2014' => 74},
             'Views' => {'2011' => 0, '2012' => 4, '2013' => 3, '2014' => 5},
           'Uniques' => {'2011' => 1, '2012' => 3, '2013' => 0, '2014' => 1}}
  chart data, type: :two_axis, height: 150, labels: [true, false, false], formats: [:currency, :integer], line_width: 0.5, colors: ['6f3d79', '7d807f']
end
