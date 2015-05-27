require 'spec_helper'

describe Prawn::Chart::Graph do
  let(:pdf) { Prawn::Document.new }
  let(:data) { {} }
  let(:output) { pdf.render }
  let(:line) { PDF::Inspector::Graphics::Line.analyze output }

  it 'has a default height of 200' do
    pdf.stroke_horizontal_rule
    pdf.chart data
    pdf.stroke_horizontal_rule
    y = line.points.each_slice(2).map{|x| x.first.last}
    height = y.first - y.last
    expect(height).to eq 200.0
  end

  it 'changes its height based on the :height setting' do
    pdf.stroke_horizontal_rule
    pdf.chart data, height: 300
    pdf.stroke_horizontal_rule
    y = line.points.each_slice(2).map{|x| x.first.last}
    height = y.first - y.last
    expect(height).to eq 300.0
  end
end
