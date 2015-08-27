# By default, <code>chart</code> generates charts with default colors.
#
# You can use the <code>:color</code> option to manually set the color.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 18.2, 2014 => 4.6, 2015 => 10.2}}
  chart data, color: '6f3d79'
end
