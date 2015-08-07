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

  describe 'border' do
    let(:border) { %w(1 t T true TRUE).sample }

    it 'is false by default' do
      ENV['SQUID_BORDER'] = nil
      expect(config.border).to be false
    end

    it 'can be set with the environment variable SQUID_BORDER' do
      ENV['SQUID_BORDER'] = border
      expect(config.border).to be true
      ENV['SQUID_BORDER'] = nil
    end
  end

  describe 'chart' do
    let(:chart) { %w(0 f F false FALSE).sample }

    it 'is true by default' do
      ENV['SQUID_CHART'] = nil
      expect(config.chart).to be true
    end

    it 'can be set with the environment variable SQUID_CHART' do
      ENV['SQUID_CHART'] = chart
      expect(config.chart).to be false
      ENV['SQUID_CHART'] = nil
    end
  end

  describe 'color' do
    let(:color) { %w(5d9648 e7a13d bc2d30 6f3d79 7d807f).sample }

    it 'is blue by default' do
      ENV['SQUID_COLOR'] = nil
      expect(config.color).to eq '2e578c'
    end

    it 'can be set with the environment variable SQUID_COLOR' do
      ENV['SQUID_COLOR'] = color
      expect(config.color).to eq color
      ENV['SQUID_COLOR'] = '2e578c'
    end
  end

  describe 'format' do
    let(:format) { %i(percentage currency seconds float).sample }

    it 'is integer by default' do
      ENV['SQUID_FORMAT'] = nil
      expect(config.format).to be :integer
    end

    it 'can be set with the environment variable SQUID_FORMAT' do
      ENV['SQUID_FORMAT'] = format.to_s
      expect(config.format).to be format
      ENV['SQUID_FORMAT'] = nil
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

  describe 'steps' do
    let(:steps) { rand(9) }

    it 'is 4 by default' do
      ENV['SQUID_STEPS'] = nil
      expect(config.steps).to eq 4
    end

    it 'can be set with the environment variable SQUID_STEPS' do
      ENV['SQUID_STEPS'] = steps.to_s
      expect(config.steps).to eq steps
      ENV['SQUID_STEPS'] = nil
    end
  end

  describe 'height' do
    let(:height) { rand(600).to_f }

    it 'is 250 by default' do
      ENV['SQUID_HEIGHT'] = nil
      expect(config.height).to eq 250.0
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

  describe 'type' do
    let(:type) { %i(point).sample }

    it 'is integer by default' do
      ENV['SQUID_TYPE'] = nil
      expect(config.type).to be :column
    end

    it 'can be set with the environment variable SQUID_TYPE' do
      ENV['SQUID_TYPE'] = type.to_s
      expect(config.type).to be type
      ENV['SQUID_TYPE'] = nil
    end
  end

  describe 'value_labels' do
    let(:value_labels) { %w(1 t T true TRUE).sample }

    it 'is false by default' do
      ENV['SQUID_VALUE_LABELS'] = nil
      expect(config.value_labels).to be false
    end

    it 'can be set with the environment variable SQUID_VALUE_LABELS' do
      ENV['SQUID_VALUE_LABELS'] = value_labels
      expect(config.value_labels).to be true
      ENV['SQUID_VALUE_LABELS'] = nil
    end
  end
end
