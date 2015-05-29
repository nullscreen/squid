require 'spec_helper'

describe Prawn::Chart::AxisValue do
  let(:pdf) { Prawn::Document.new }
  let(:empty_data) { {views: {}} }
  let(:valid_data) { {uploads: {us: 9109, fr: 456}, views: {us: 109, fr: 456} }}
  let(:options) { {legend: false} }
  let(:output) { pdf.render }
  let(:text) { PDF::Inspector::Text.analyze output }

  specify 'does not print anything given no data' do
    pdf.chart
    expect(text.strings).to be_empty
  end

  specify 'draws 4 labels on the left side of the graph starting with the max values, rounded to the two most significant digits' do
    pdf.chart valid_data, options
    expect(text.strings).to include *%w(460 345 230 115 0)
  end

  specify 'draws 4 labels on the right side if the chart type is :two_axis' do
    pdf.chart valid_data, options.merge(type: :two_axis)
    expect(text.strings).to include *%w(460 9,100 345 6,825 230 4,550 115 2,275 0 0)
  end

  specify 'format the labels as percentage if the format is :percentage' do
    pdf.chart valid_data, options.merge(format: :percentage)
    expect(text.strings).to include *%w(460.0% 345.0% 230.0% 115.0% 0.0%)
  end
end