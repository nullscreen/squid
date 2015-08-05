require 'spec_helper'

describe 'Graph legend', inspect: true do
  before { pdf.chart data, options }

  context 'given no series, does not have any text' do
    it { expect(inspected_text.strings).to be_empty }
  end

  context 'given one series' do
    let(:data) { {views: views} }

    it 'includes the titleized name of the series' do
      expect(inspected_text.strings).to eq ['Views']
    end

    it 'draws a small square representing the series' do
      square = inspected_rectangle.rectangles.first
      expect(square[:width]).to be 5.0
      expect(square[:height]).to be 5.0
    end
  end

  context 'given two series' do
    let(:data) { {views: views, uniques: uniques} }

    it 'includes the titleized names of both series' do
      expect(inspected_text.strings).to eq ['Views', 'Uniques']
    end

    it 'prints both names on the same text line' do
      lines = inspected_text.positions.map(&:last).uniq
      expect(lines).to be_one
    end
  end
end
