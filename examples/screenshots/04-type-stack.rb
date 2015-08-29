filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 134}, uniques: {2013 => 98, 2014 => 32, 2015 => 61}}
  chart data, type: :stack
end
