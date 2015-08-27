filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {safari:  {2013 => 53.2, 2014 => 56.1, 2015 => 60.7}, firefox:  {2013 => 46.8, 2014 => 43.9, 2015 => 39.3}}
  chart data, type: :line, color: '6f3d79', format: :percentage, line_width: 0.5, label: true
end
