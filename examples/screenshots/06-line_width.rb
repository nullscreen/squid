filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {'Views' => {2013 => 182, 2014 => 46, 2015 => 134}, 'Uniques' => {2013 => 98, 2014 => 32, 2015 => 61}}
  chart data, type: :line, line_widths: [2, 6]
end
