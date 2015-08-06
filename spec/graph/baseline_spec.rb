require 'spec_helper'

describe 'Graph baseline', inspect: true do
  let(:options) { {gridlines: 0} }

  specify 'given no series, is not drawn' do
    pdf.chart no_series, options
    expect(inspected_line.points).to be_empty
  end

  context 'given one or more series' do
    before { pdf.chart [one_series, two_series].sample, options }

    it 'is drawn' do
      expect(inspected_line.points).not_to be_empty
    end

    it 'starts somewhere between 0 and 100 (depending on the width of the labels)' do
      left = pdf.page.margins[:left]
      expect(inspected_line.points.first.first).to be_within(50).of(50 + left)
    end

    it 'ends at the right of the bounding box' do
      right = pdf.bounds.right + pdf.page.margins[:left]
      expect(inspected_line.points.last.first).to eq right
    end
  end

  it 'can be disabled with the :baseline option' do
    pdf.chart one_series, options.merge(baseline: false)
    expect(inspected_line.points).to be_empty
  end

  it 'can be disabled with Squid.config' do
    Squid.configure {|config| config.baseline = false}
    pdf.chart one_series, options
    Squid.configure {|config| config.baseline = true}
    expect(inspected_line.points).to be_empty
  end
end
