# By default, <code>chart</code> plots a graph for each series.
#
# Provide multiple key/value pairs to <code>:data</code> to plot multiple series.
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 182, 2014 => 46, 2015 => 88},
        uniques: {2013 => 104, 2014 => -27, 2015 => 14}}
  chart data, label: true, format: :percentage
end
