require 'spec_helper'

describe 'Graph legend', inspect: true do
  let(:options) { {gridlines: 0} }

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
      square = inspected_rectangle.rectangles.first
      expect(square[:width]).to be 5.0
      expect(square[:height]).to be 5.0
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
end
