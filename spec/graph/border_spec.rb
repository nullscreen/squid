require 'spec_helper'

describe 'Graph border', inspect: true do
  let(:options) { {chart: false, legend: false} }

  specify 'given no series, is not printed' do
    pdf.chart no_series, options
    expect(inspected_rectangles).to be_empty
  end

  context 'given one or more series' do
    before { pdf.chart [one_series, two_series].sample, options }

    it 'is not printed by default' do
      expect(inspected_rectangles).to be_empty
    end
  end

  it 'can be enabled with the :border option' do
    pdf.chart one_series, options.merge(border: true)
    expect(inspected_rectangles).not_to be_empty
  end

  it 'can be enable with Squid.config' do
    Squid.configure {|config| config.border = true}
    pdf.chart one_series, options
    Squid.configure {|config| config.border = false}
    expect(inspected_rectangles).not_to be_empty
  end
end
