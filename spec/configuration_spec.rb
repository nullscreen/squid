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

  describe 'legend' do
    let(:legend) { %w(0 f F false FALSE).sample }

    it 'is true by default' do
      ENV['SQUID_LEGEND'] = nil
      expect(config.legend).to be true
    end

    it 'can be set with the environment variable SQUID_LEGEND' do
      ENV['SQUID_LEGEND'] = legend
      expect(config.legend).to be false
      ENV['SQUID_LEGEND'] = nil
    end
  end

  describe 'gridlines' do
    let(:gridlines) { rand(9) }

    it 'is 4 by default' do
      ENV['SQUID_GRIDLINES'] = nil
      expect(config.gridlines).to eq 4
    end

    it 'can be set with the environment variable SQUID_GRIDLINES' do
      ENV['SQUID_GRIDLINES'] = gridlines.to_s
      expect(config.gridlines).to eq gridlines
      ENV['SQUID_GRIDLINES'] = nil
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

  describe 'ticks' do
    let(:ticks) { %w(0 f F false FALSE).sample }

    it 'is true by default' do
      ENV['SQUID_TICKS'] = nil
      expect(config.ticks).to be true
    end

    it 'can be set with the environment variable SQUID_TICKS' do
      ENV['SQUID_TICKS'] = ticks
      expect(config.ticks).to be false
      ENV['SQUID_TICKS'] = nil
    end
  end
end
