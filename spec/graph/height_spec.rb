require 'spec_helper'

describe 'Graph height' do
  let(:default_height) { Squid.configuration.height }
  let(:options) { {} }
  let(:height) {
    pdf = Prawn::Document.new
    pdf.stroke_horizontal_rule
    pdf.chart options
    pdf.stroke_horizontal_rule
    output = pdf.render
    line = PDF::Inspector::Graphics::Line.analyze output
    y = line.points.each_slice(2).map{|x| x.first.last}
    height = y.first - y.last
  }

  it 'uses the Squid.configuration value by default' do
    expect(height).to eq default_height
  end

  context 'can be set calling chart with the :height option' do
    let(:options) { {height: 300} }
    it { expect(height).to eq 300.0 }
  end

  context 'can be set with Squid.config' do
    before { Squid.configure {|config| config.height = 400} }
    after  { Squid.configure {|config| config.height = default_height } }
    it { expect(height).to eq 400.0 }
  end
end
