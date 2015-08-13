filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {safari:  {2013 => 43.2, 2014 => 46.1, 2015 => 50.7}, firefox:  {2013 => 56.8, 2014 => 53.9, 2015 => 49.3}}
  chart data, value_labels: true, format: :percentage
end
