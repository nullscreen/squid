# By default, <code>chart</code> generates charts with a height of 200.
# You can use the <code>:height</code> option to manually set the height.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 102}}
  
  text 'Default height:'
  chart data
  move_down 30

  text 'Custom height:'
  chart data, height: 100
end
