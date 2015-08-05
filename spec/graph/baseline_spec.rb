require 'spec_helper'

describe 'Graph baseline', inspect: true do
  let(:baseline) { inspected_line.points.map &:first }

  it 'spans the whole width of the page' do
    pdf.chart
    expect(baseline.last - baseline.first).to eq pdf.bounds.width
  end

  context 'can be disabled setting the :baseline option to false' do
    let(:options) { {baseline: false} }
    it { expect(baseline).to be_empty }
  end

  context 'can be disabled with Squid.config' do
    let(:options) { {baseline: false} }
    it { expect(baseline).to be_empty }
  end

  context 'can be set with Squid.config' do
    before(:all) do
      @original = Squid.configuration.baseline
      Squid.configure {|config| config.baseline = false}
    end
    after(:all) { Squid.configure {|config| config.baseline = @original} }
    it { expect(baseline).to be_empty }
  end
end
