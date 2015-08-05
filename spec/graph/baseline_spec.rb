require 'spec_helper'

describe 'Graph baseline' do
  let(:pdf) { Prawn::Document.new }
  let(:baseline_width) {
    pdf.chart
    output = pdf.render
    line = PDF::Inspector::Graphics::Line.analyze output
    baseline_starts, baseline_ends = line.points.map(&:first)
    baseline_ends - baseline_starts
  }

  it 'spans the whole width of the page' do
    expect(baseline_width).to eq pdf.bounds.width
  end
end
