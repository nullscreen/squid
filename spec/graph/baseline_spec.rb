require 'spec_helper'

describe 'Graph baseline', inspect: true do
  let(:baseline) { inspected_points.map &:first }
  let(:options) { {gridlines: 0} }

  it 'spans the whole width of the page' do
    pdf.chart data, options
    expect(inspected_points.size).to be 1
    left, right = inspected_points.first.map(&:first)
    expect(right - left).to eq pdf.bounds.width
  end

  it 'can be disabled setting the :baseline option to false' do
    pdf.chart data, options.merge(baseline: false)
    expect(baseline).to be_empty
  end

  it 'can be disabled with Squid.config' do
    Squid.configure {|config| config.baseline = false}
    pdf.chart data, options
    Squid.configure {|config| config.baseline = true}
    expect(baseline).to be_empty
  end
end
