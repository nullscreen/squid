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

    it 'has blue columns' do
      expect(inspected_color.fill_color).to eq [0.18, 0.341, 0.549]
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

    context 'given the :type is set to :point' do
      let(:options) { {legend: false, baseline: false, steps: 0, type: :point} }

      it 'prints the elements as circles of the same radius' do
        expect(inspected_rectangles).to be_empty
        expect(inspected_coords).not_to be_empty
        radii = inspected_points.map{|x| x.map(&:first).inject(:-)}
        expect(radii.uniq).to be_one
      end
    end

    context 'given the :type is set to :line' do
      let(:options) { {legend: false, baseline: false, steps: 0, type: :line} }

      it 'prints the elements by connecting them with lines' do
        expect(inspected_rectangles).to be_empty
        expect(inspected_points.size).to be values.size - 1
      end

      context 'given the :line_width option is set to a value' do
        let(:options) { {legend: false, baseline: false, steps: 0, type: :line, line_width: 10} }

        it 'draws the line with the given width' do
          expect(inspected_line.widths).to include(10)
        end
      end

      context 'given the :value_labels option is set' do
        let(:options) { {legend: false, baseline: false, steps: 0, type: :line, value_labels: true} }

        it 'draws the value labels on top of each line' do
          expect(inspected_strings).not_to be_empty
        end
      end
    end
  end

  context 'given many series' do
    let(:series_1) { {2013 => 110, 2014 => 30, 2015 => 13} }
    let(:series_2) { {2013 => -50, 2014 => 10, 2015 => 53} }
    let(:series_3) { {2013 => 20, 2014 => 140, 2015 => -3} }
    let(:data) { {series_1: series_1, series_2: series_2, series_3: series_3} }
    before { pdf.chart data, options }

    it 'includes one column for each value of each series' do
      expect(inspected_rectangles.size).to be 9
    end

    it 'has columns of the same width' do
      widths = inspected_rectangles.map{|r| r[:width]}
      expect(widths.uniq).to be_one
    end

    it 'does not only have blue columns' do
      expect(inspected_color.fill_color).to eq [0.906, 0.631, 0.239]
    end

    context 'given the :type is set to :point' do
      let(:options) { {legend: false, baseline: false, steps: 0, type: :point} }

      it 'prints the one circle for each value of each series' do
        expect(inspected_rectangles).to be_empty
        expect(inspected_coords.size/28).to be 9
      end
    end

    context 'given the :type is set to :line' do
      let(:options) { {legend: false, baseline: false, steps: 0, type: :line} }

      it 'includes one line for each series' do
        expect(inspected_rectangles).to be_empty
        expect(inspected_points.size).to be 6
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

  it 'can have different colors with the :colors option' do
    pdf.chart one_series, options.merge(colors: ['5d9648'])
    expect(inspected_color.fill_color).to eq [0.365, 0.588, 0.282]
  end

  it 'can have a different color with Squid.config' do
    Squid.configure {|config| config.colors = ['5d9648']}
    pdf.chart one_series, options
    Squid.configure {|config| config.colors = %w(2e578c 5d9648 e7a13d bc2d30 6f3d79 7d807f)}
    expect(inspected_color.fill_color).to eq [0.365, 0.588, 0.282]
  end

  it 'can have a different type with the :type option' do
    pdf.chart one_series, options.merge(type: :point)
    expect(inspected_rectangles).to be_empty
  end

  it 'can have a different type with Squid.config' do
    Squid.configure {|config| config.type = :point}
    pdf.chart one_series, options
    Squid.configure {|config| config.type = :column}
    expect(inspected_rectangles).to be_empty
  end

  it 'can have a different line width with the :line_width option' do
    pdf.chart one_series, options.merge(type: :line, line_width: 7)
    expect(inspected_line.widths).to include(7)
  end

  it 'can have a different line width with Squid.config' do
    Squid.configure {|config| config.type = :line; config.line_width = 7}
    pdf.chart one_series, options
    Squid.configure {|config| config.type = :column; config.line_width = 3}
    expect(inspected_line.widths).to include(7)
  end
end
