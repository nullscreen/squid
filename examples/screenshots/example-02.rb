filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  data = {satisfaction: (1..7).map{|x| ["Jan #{x}", rand(100)]}.to_h}


  chart data, type: :point, label: true, format: :percentage, every: 3
end
