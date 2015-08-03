require 'spec_helper'

describe Squid::Graph do
  let(:pdf) { Prawn::Document.new }
  let(:data) { {} }
  let(:output) { pdf.render }
  let(:rectangle) { PDF::Inspector::Graphics::Rectangle.analyze output }

  it 'fills the width of the page (or equivalent bounding box)' do
    pdf.chart

    graph_width = rectangle.rectangles.first[:width]
    expect(graph_width).to eq pdf.bounds.width
  end
end
