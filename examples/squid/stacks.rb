# By default, <code>chart</code> plots multiple columns next to each other.
#
# You can use the <code>:type</code> option to plot stacked columns instead.
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {views: {2013 => 196, 2014 => 66, 2015 => -282},
           hits: {2013 => 100, 2014 => -12, 2015 => 82},
        uniques: {2013 => -114, 2014 => 47, 2015 => -14}}
  chart data, type: :stack, labels: [true, false, true], formats: [:currency, :float, :percentage]
end
