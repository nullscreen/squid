# By default, <code>chart</code> adds a legend in the top-right corner of the chart,
# listing the labels of all the series in the graph.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  views = {2013 => 182, 2014 => 46, 2015 => 102}
  uniques = {2013 => 110, 2014 => 30, 2015 => 88}

  text 'Without two series:'
  chart views: views, uniques: uniques
end
