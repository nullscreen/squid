require 'spec_helper'

describe 'Graph legend', inspect: true do
  let(:options) { {steps: 0, baseline: false, chart: false} }

  specify 'given no series, is not printed' do
    pdf.chart no_series, options
    expect(inspected_strings).to be_empty
  end

  context 'given one series' do
    before { pdf.chart one_series, options }

    it 'includes the titleized name of the series' do
      expect(inspected_strings).to eq ['Views']
    end

    it 'draws a small square representing the series' do
      square = inspected_rectangles.first
      expect(square[:width]).to be 5.0
      expect(square[:height]).to be 5.0
    end

    it 'draws the square in blue' do
      expect(inspected_colors.fill_color).to eq [0.18, 0.341, 0.549]
    end
  end

  context 'given two series' do
    before { pdf.chart two_series, options }

    it 'includes the titleized names of both series' do
      expect(inspected_strings).to eq ['Views', 'Uniques']
    end

    it 'prints both names on the same text line' do
      lines = inspected_text.positions.map(&:last).uniq
      expect(lines).to be_one
    end
  end

  it 'can be disabled setting the :legend option to false' do
    pdf.chart one_series, options.merge(legend: false)
    expect(inspected_strings).to be_empty
  end

  it 'can be disabled with Squid.config' do
    Squid.configure {|config| config.legend = false}
    pdf.chart one_series, options
    Squid.configure {|config| config.legend = true}
    expect(inspected_strings).to be_empty
  end

  it 'can have a different color with the :color option' do
    pdf.chart one_series, options.merge(color: '5d9648')
    expect(inspected_colors.fill_color).to eq [0.365, 0.588, 0.282]
  end

  it 'can have a different color with Squid.config' do
    Squid.configure {|config| config.color = '5d9648'}
    pdf.chart one_series, options
    Squid.configure {|config| config.color = '2e578c'}
    expect(inspected_colors.fill_color).to eq [0.365, 0.588, 0.282]
  end
end
