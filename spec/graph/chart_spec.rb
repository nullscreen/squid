require 'spec_helper'

describe 'Graph chart', inspect: true do
  let(:options) { {legend: false} }

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

    context 'given the series has nil values' do
      let(:values) { {2013 => -50, 2014 => nil, 2015 => 20} }

      it 'ignores nil values' do
        expect(inspected_rectangles.select{|r| r[:height].zero?}).to be_one
      end
    end
  end
end
