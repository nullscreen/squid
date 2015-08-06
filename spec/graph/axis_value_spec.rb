require 'spec_helper'

describe 'Graph axis values', inspect: true do
  let(:options) { {legend: false, baseline: false} }

  specify 'given no series, does not print any axis value' do
    pdf.chart no_series, options
    expect(inspected_strings).to be_empty
  end

  context 'given one series' do
    let(:values) { {2013 => 50, 2014 => -30, 2015 => 20} }
    let(:data) { {series: values} }
    before { pdf.chart data, options }

    it 'are as many as steps + 1 (on the baseline)' do
      expect(inspected_strings.size).to be 5
    end

    it 'start with the series maximum' do
      max = values.values.max
      expect(inspected_strings.first.to_i).to eq max
    end

    it 'end with the series minimum' do
      min = values.values.min
      expect(inspected_strings.last.to_i).to eq min
    end

    it 'range equidistant values from the series minimum to maximum' do
      distance = inspected_strings.map(&:to_f).each_cons(2).map {|a, b| a - b}
      expect(distance.uniq).to be_one
    end

    it 'are vertically positioned along the equidistant horizontal gridlines' do
      distance = inspected_text.positions.each_cons(2).map do |x|
        (x.first.last - x.last.last).round(2)
      end
      expect(distance.uniq).to be_one
    end

    it 'are horizontally positioned between 0 and 100' do
      left_point = inspected_text.positions.map &:first
      expect(left_point).to all (be_within(50).of(50))
    end

    context 'given the series minimum is greater than zero' do
      let(:values) { {2013 => 50, 2014 => 30, 2015 => 20} }

      it 'ends with zero' do
        expect(inspected_strings.last.to_i).to be_zero
      end
    end

    context 'given the series maximum is lower than the number of steps' do
      let(:values) { {2013 => 1, 2014 => 2, 2015 => 2} }

      it 'starts with the number of steps' do
        expect(inspected_strings.first.to_i).to eq 4
      end
    end

    context 'given the axis values have more than 2 significant digits' do
      let(:values) { {2013 => 18212, 2014 => 4634, 2015 => 10256} }

      it 'displays the axis values with delimiter and 2 significant digits' do
        expect(inspected_strings).to eq %w(18,000 13,500 9,000 4,500 0)
      end
    end

    context 'given the series has nil values' do
      let(:values) { {2013 => -50, 2014 => nil, 2015 => 20} }

      it 'ignores nil values' do
        expect(inspected_strings.first.to_i).to be 20
        expect(inspected_strings.last.to_i).to be -50
      end
    end

    context 'given the :format is set to :percentage' do
      let(:values) { {2013 => 42.10001, 2014 => 39.29999, 2015 => 18.6} }
      let(:options) { {legend: false, baseline: false, format: :percentage} }

      it 'prints the values as rounded percentages' do
        expect(inspected_strings).to eq %w(42.0% 31.5% 21.0% 10.5% 0.0%)
      end
    end

    context 'given the :format is set to :currency' do
      let(:values) { {2013 => 42.009, 2014 => 390.1, 2015 => 18.6} }
      let(:options) { {legend: false, baseline: false, format: :currency} }

      it 'prints the values as rounded percentages' do
        expect(inspected_strings).to eq %w($390.00 $292.50 $195.00 $97.50 $0.00)
      end
    end

    context 'given the :format is set to :seconds' do
      let(:values) { {2013 => 42.009, 2014 => 390.1, 2015 => 18.6} }
      let(:options) { {legend: false, baseline: false, format: :seconds} }

      it 'prints the values as minutes and seconds' do
        expect(inspected_strings).to eq %w(6:30 4:53 3:15 1:38 0:00)
      end
    end

    context 'given the :format is set to :float' do
      let(:values) { {2013 => 42.009, 2014 => 390.1, 2015 => 18.6} }
      let(:options) { {legend: false, baseline: false, format: :float} }

      it 'prints the values as floats' do
        expect(inspected_strings).to eq %w(390.0 292.5 195.0 97.5 0.0)
      end
    end
  end

  it 'can be set with the :steps option' do
    pdf.chart one_series, options.merge(steps: 8)
    expect(inspected_strings.size).to be 9
  end

  it 'can be set with Squid.config' do
    Squid.configure {|config| config.steps = 6}
    pdf.chart one_series, options
    Squid.configure {|config| config.steps = 4}

    expect(inspected_strings.size).to be 7
  end

  it 'can have a different format with the :format option' do
    pdf.chart one_series, options.merge(format: :percentage)
    expect(inspected_strings).to eq %w(180.0% 135.0% 90.0% 45.0% 0.0%)
  end

  it 'can be drawn without ticks with Squid.config' do
    Squid.configure {|config| config.format = :percentage}
    pdf.chart one_series, options
    Squid.configure {|config| config.format = nil}
    expect(inspected_strings).to eq %w(180.0% 135.0% 90.0% 45.0% 0.0%)
  end
end
