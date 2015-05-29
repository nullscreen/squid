require 'spec_helper'

describe Prawn::Chart::Category do
  let(:pdf) { Prawn::Document.new }
  let(:data) { {views: {us: 10, fr: 40}} }
  let(:options) { {ticks: true, type: :line} }
  let(:output) { pdf.render }
  let(:line) { PDF::Inspector::Graphics::Line.analyze output }

  specify 'draws 2 ticks (with height 2) given the :ticks options' do
    pdf.chart data, options
    ticks = line.points.each_slice(2).count{|x| x.first.last-x.last.last == 2.0}
    expect(ticks).to be 2
  end
end
