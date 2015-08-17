# By default, <code>chart</code> plots every category on the baseline.
#
# You can use the <code>:every</code> option to change this behavior.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
 data = {views: {'Jan 1' => 12, 'Jan 2' => 13, 'Jan 3' => 21, 'Jan 4' => 42,
 'Jan 5' => 32, 'Jan 6' => 45, 'Jan 7' => 62, 'Jan 8' => 22, 'Jan 9' => 31,
 'Jan 10' => 11, 'Jan 11' => 40, 'Jan 12' => 6, 'Jan 13' => 9}}
 chart data, every: 3
end
