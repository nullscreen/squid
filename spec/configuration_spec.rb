require 'spec_helper'

describe Squid::Configuration do
  subject(:config) { Squid::Configuration.new }

  describe 'height' do
    let(:height) { rand(600).to_f }

    it 'is 200 by default' do
      ENV['SQUID_HEIGHT'] = nil
      expect(config.height).to eq 200.0
    end

    it 'can be set with the environment variable SQUID_HEIGHT' do
      ENV['SQUID_HEIGHT'] = height.to_s
      expect(config.height).to eq height
    end
  end
end