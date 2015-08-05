require 'spec_helper'

describe 'Graph height', inspect: true do
  before do
    pdf.stroke_horizontal_rule
    pdf.chart data, options
    pdf.stroke_horizontal_rule
  end

  let(:y) { inspected_line.points.each_slice(2).map{|x| x.first.last} }
  let(:height) { y.first - y.last }

  context 'uses the Squid.configuration value by default' do
    it { expect(height).to eq Squid.configuration.height }
  end

  context 'can be set calling chart with the :height option' do
    let(:options) { {height: 300} }
    it { expect(height).to eq 300.0 }
  end

  context 'can be set with Squid.config' do
    before(:all) do
      @original = Squid.configuration.height
      Squid.configure {|config| config.height = 400}
    end
    after(:all) { Squid.configure {|config| config.height = @original} }
    it { expect(height).to eq 400.0 }
  end
end
