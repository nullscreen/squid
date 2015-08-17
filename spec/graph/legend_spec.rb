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

    it 'starts (right to left) from the right margin of the graph' do
      right = inspected_text.positions.first.first
      expect(right).to be_within(3).of(pdf.bounds.right + 20)
    end

    context 'given the legend: :offset option is provided' do
      let(:offset) { 50 }
      let(:options) { {steps: 0, baseline: false, chart: false, legend: {offset: offset}} }

      it 'starts (right to left) from the right margin of the graph + offset' do
        right = inspected_text.positions.first.first
        expect(right).to be_within(3).of(pdf.bounds.right + 20 - offset)
      end
    end

    it 'draws a small square representing the series' do
      square = inspected_rectangles.first
      expect(square[:width]).to be 5.0
      expect(square[:height]).to be 5.0
    end

    it 'draws the square in blue' do
      expect(inspected_color.fill_color).to eq [0.18, 0.341, 0.549]
    end
  end

  context 'given two series' do
    before { pdf.chart two_series, options }

    it 'includes the titleized names of both series' do
      expect(inspected_strings.reverse).to eq ['Views', 'Uniques']
    end

    it 'prints both names on the same text line' do
      lines = inspected_text.positions.map(&:last).uniq
      expect(lines).to be_one
    end

    it 'does not only draw the squares in green' do
      expect(inspected_color.fill_color).to eq [0.18, 0.341, 0.549]
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

  it 'can have different colors with the :colors option' do
    pdf.chart one_series, options.merge(colors: ['5d9648'])
    expect(inspected_color.fill_color).to eq [0.365, 0.588, 0.282]
  end

  it 'can have different colors with Squid.config' do
    Squid.configure {|config| config.colors = ['5d9648']}
    pdf.chart one_series, options
    Squid.configure {|config| config.colors = %w(2e578c 5d9648 e7a13d bc2d30 6f3d79 7d807f)}
    expect(inspected_color.fill_color).to eq [0.365, 0.588, 0.282]
  end

  it 'can have an offset from the right margin with the legend: :offset option' do
    offset = 80
    pdf.chart one_series, options.merge(legend: {offset: offset})
    right = inspected_text.positions.first.first
    expect(right).to be_within(3).of(pdf.bounds.right + 20 - offset)
  end
end
