require 'spec_helper'

describe 'Graph chart', inspect: true do
  let(:options) { {legend: false, baseline: false, steps: 0} }

  specify 'given no series, is not printed' do
    pdf.chart no_series, options
    expect(inspected_rectangles).to be_empty
  end

  context 'given one series' do
    let(:values) { {2013 => 50, 2014 => -30, 2015 => 20} }
    let(:data) { {series: values} }
    before { pdf.chart data, options }

    it 'includes one column for each value of the series' do
      expect(inspected_rectangles.size).to be values.size
    end

    it 'has columns of the same width' do
      widths = inspected_rectangles.map{|r| r[:width]}
      expect(widths.uniq).to be_one
    end

    it 'has all the columns aligned along the "0" value of the graph' do
      y = inspected_rectangles.map{|r| r[:point].last}
      expect(y.uniq).to be_one
    end

    it 'does not include value labels on top of the chart' do
      expect(inspected_strings).to be_empty
    end

    context 'given the series has nil values' do
      let(:values) { {2013 => -50, 2014 => nil, 2015 => 20} }

      it 'ignores nil values' do
        expect(inspected_rectangles.select{|r| r[:height].zero?}).to be_one
      end
    end
  end

  it 'can be disabled with the :chart option' do
    pdf.chart one_series, options.merge(chart: false)
    expect(inspected_rectangles).to be_empty
  end

  it 'can be disabled with Squid.config' do
    Squid.configure {|config| config.chart = false}
    pdf.chart one_series, options
    Squid.configure {|config| config.chart = true}
    expect(inspected_rectangles).to be_empty
  end

  it 'can have value labels with the :value_labels option' do
    pdf.chart one_series, options.merge(value_labels: true)
    expect(inspected_strings).not_to be_empty
  end

  it 'can be drawn without ticks with Squid.config' do
    Squid.configure {|config| config.value_labels = :true}
    pdf.chart one_series, options
    Squid.configure {|config| config.value_labels = false}
    expect(inspected_strings).not_to be_empty
  end
end
