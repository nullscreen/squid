# By default, <code>chart</code> plots a baseline at the bottom of the graph.
# You can use the <code>:baseline</code> option to disable this behavior.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 102}}
  
  text 'With baseline (default):'
  chart data
  move_down 30

  text 'Without baseline:'
  chart data, baseline: false
end
