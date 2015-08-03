# Creating graphs with Squid is easy. Just use the <code>chart</code> method.
#
# The most simple graph can be created by providing only a hash containing
# the data of the series you want to plot.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  chart
end
