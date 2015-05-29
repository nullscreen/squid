require 'spec_helper'

describe Prawn::Chart::Legend do
  let(:pdf) { Prawn::Document.new }
  let(:data) { {views: {}} }
  let(:output) { pdf.render }
  let(:text) { PDF::Inspector::Text.analyze output }
  let(:rectangle) { PDF::Inspector::Graphics::Rectangle.analyze output }

  specify 'does not print anything given no data' do
    pdf.chart
    expect(text.strings).to be_empty
  end

  context 'given data with one series' do
    it 'includes the titleized name of the series' do
      pdf.chart data
      expect(text.strings).to include *%w(Views)
    end

    it 'includes a square to represent each series' do
      pdf.chart data
      expect(rectangle.rectangles).to include point: anything, width: 5.0, height: 5.0
    end

    it 'changes its horizontal position based on {legend: :x_offset}' do
      pdf.chart data
      pdf.chart data, legend: {x_offset: -65}
      expect(text.positions.map(&:first).uniq).not_to be_one
    end
  end

  context 'given data with two series' do
    specify 'includes the titleized name of both series' do
      pdf.chart data.merge(uploads: {})
      expect(text.strings).to include *%w(Views Uploads)
    end
  end
end
