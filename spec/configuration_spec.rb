require 'spec_helper'

describe Squid::Configuration do
  subject(:config) { Squid::Configuration.new }

  describe 'baseline' do
    let(:baseline) { %w(0 f F false FALSE).sample }

    it 'is true by default' do
      ENV['SQUID_BASELINE'] = nil
      expect(config.baseline).to be true
    end

    it 'can be set with the environment variable SQUID_BASELINE' do
      ENV['SQUID_BASELINE'] = baseline
      expect(config.baseline).to be false
      ENV['SQUID_BASELINE'] = nil
    end
  end

  describe 'height' do
    let(:height) { rand(600).to_f }

    it 'is 200 by default' do
      ENV['SQUID_HEIGHT'] = nil
      expect(config.height).to eq 200.0
    end

    it 'can be set with the environment variable SQUID_HEIGHT' do
      ENV['SQUID_HEIGHT'] = height.to_s
      expect(config.height).to eq height
      ENV['SQUID_HEIGHT'] = nil
    end
  end
end