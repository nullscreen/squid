filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {earnings: {2013 => 94_323, 2014 => 81_234, 2015 => 74_123}, views: {2013 => 182, 2014 => 124, 2015 => 88}, uniques: {2013 => 153, 2014 => 96, 2015 => 78} }
  chart data, type: :two_axis, label: true, format: :currency, line_width: 4
end
