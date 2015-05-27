require 'spec_helper'

describe Prawn::Chart::Interface do
  let(:pdf) { Prawn::Document.new }

  specify 'keeps Prawn::Document methods intact (e.g "text")' do
    pdf.text 'hello'
    output = PDF::Inspector::Page.analyze pdf.render
    text = output.pages[0][:strings][0]
    expect(text).to eq 'hello'
  end

  specify 'adds the "chart" method to Prawn::Document' do
    expect{pdf.chart}.not_to raise_error
  end
end
