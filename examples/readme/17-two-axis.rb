filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 88}, earnings: {2013 => 104_323, 2014 => 27_234, 2015 => 14_123}}
  chart data, type: :two_axis
end


