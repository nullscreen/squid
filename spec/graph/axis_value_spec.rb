require 'spec_helper'

describe 'Graph axis values', inspect: true do
  before { pdf.chart data, options.merge(legend: false) }

  context 'given no series, does not print any axis value' do
    it { expect(inspected_strings).to be_empty }
  end

  context 'given one series' do
    let(:data) { {subscribers: subscribers} }

    context 'by default' do
      it 'are gridlines + 1 (for the baseline)' do
        expect(inspected_strings.size).to be 5
      end

      it 'start with the series maximum' do
        expect(inspected_strings.first.to_i).to eq subscribers.values.max
      end

      it 'end with the series minimum' do
        expect(inspected_strings.last.to_i).to eq subscribers.values.min
      end

      it 'range equidistant values from the series minimum to maximum' do
        distance = inspected_strings.map(&:to_f).each_cons(2).map {|a, b| a - b}
        expect(distance.uniq).to be_one
      end

      it 'are positioned along the equidistant horizontal gridlines' do
        left_point = inspected_text.positions.map &:first
        expect(left_point.uniq).to be_one

        distance = inspected_text.positions.each_cons(2).map do |x|
          (x.first.last - x.last.last).round(2)
        end
        expect(distance.uniq).to be_one
      end

    end

    context 'given the series minimum is greater than zero' do
      let(:subscribers) { {2013 => 50, 2014 => 30, 2015 => 20} }

      it 'ends with zero' do
        expect(inspected_strings.last.to_i).to be_zero
      end
    end

    context 'given the series maximum is lower than the number of gridlines' do
      let(:subscribers) { {2013 => 1, 2014 => 2, 2015 => 2} }

      it 'starts with the number of gridlines' do
        expect(inspected_strings.first.to_i).to eq 4
      end
    end

    context 'given the axis values have more than 2 significant digits' do
      let(:subscribers) { {2013 => 182, 2014 => 46, 2015 => 102} }

      it 'displays the axis values rounded to 2 significant digits' do
        expect(inspected_strings).to eq %w(180.0 135.0 90.0 45.0 0.0)
      end
    end

    context 'given the series has nil values' do
      let(:subscribers) { {2013 => -50, 2014 => nil, 2015 => 20} }

      it 'ignores nil values' do
        expect(inspected_strings.first.to_i).to be 20
        expect(inspected_strings.last.to_i).to be -50
      end
    end

    context 'given a :gridlines option' do
      let(:options) { {gridlines: 2} }

      it 'renders as many axis value labels as gridlines' do

      end
    end
  end
end