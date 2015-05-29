require 'spec_helper'

describe Prawn::Chart::Gridline do
  let(:pdf) { Prawn::Document.new }
  let(:empty_data) { {views: {}} }
  let(:valid_data) { {views: {us: 10, fr: 40}} }
  let(:options) { {legend: false} }
  let(:output) { pdf.render }
  let(:line) { PDF::Inspector::Graphics::Line.analyze output }

  specify 'does not print anything given no data' do
    pdf.chart
    expect(line.points).to be_empty
  end

  specify 'draws 5 equidistant horizontal lines' do
    pdf.chart valid_data, options
    y = line.points.each_slice(2).map{|x| x.first.last}
    gaps = y.each_cons(2).map{|a| a.first - a.last}
    expect(gaps.size).to be 4
    expect(gaps.uniq).to be_one
  end
end
