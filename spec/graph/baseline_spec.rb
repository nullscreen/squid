require 'spec_helper'

describe 'Graph baseline', inspect: true do
  let(:baseline) { inspected_line.points.map &:first }

  it 'spans the whole width of the page' do
    pdf.chart
    expect(baseline.last - baseline.first).to eq pdf.bounds.width
  end
end
