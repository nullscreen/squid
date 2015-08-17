filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182/3.62, 2014 => 46/3.62, 2015 => 134/3.62}}
  chart data, format: :percentage
end
