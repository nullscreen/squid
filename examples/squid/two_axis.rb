# By default, ..
#
# You can use ..
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do

  data = {earnings: {2013 => 104_323, 2014 => 27_234, 2015 => 34_123},
             views: {2013 => 182, 2014 => 46, 2015 => 88},
           uniques: {2013 => 104, 2014 => 27, 2015 => 14}}
  chart data, type: :two_axis, border: true
end
