require 'prawn/chart'

name = 'simple.pdf'
data = { views: {us: 30, fr: 45}, uploads: {us: 10, fr: 20} }

Prawn::Document.generate(name) do
  chart data
  chart data, format: :percentage, type: :two_axis
end

`open #{name}`
