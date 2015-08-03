# By default, <code>chart</code> generates charts with a height of 200.
# You can use the <code>:height</code> option to manually set the height.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  text 'Default height:'
  chart
  move_down 20

  text 'Custom height:'
  chart height: 100
end
