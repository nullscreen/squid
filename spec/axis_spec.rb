require 'spec_helper'

describe Squid::Axis do
  let(:options) { {steps: steps, stack: stack?, format: format} }
  let(:steps) { 4 }
  let(:stack?) { false }
  let(:format) { :integer }
  let(:block) { nil }
  let(:series) { [[-10.0, 109.9, 30.0], [0, 20.0, -50.0]] }

  describe '#labels' do
    subject(:axis) { Squid::Axis.new series, options }
    let(:labels) { axis.labels }

    describe 'given 0 steps' do
      let(:steps) { 0 }
      it 'returns 0 strings' do
        expect(labels.size).to be_zero
      end
    end

    describe 'given N steps' do
      let(:steps) { 1 + rand(10) }
      it 'returns N+1 strings' do
        expect(labels.size).to be steps + 1
      end
    end

    describe 'given stacked series' do
      let(:stack?) { false }
      it 'ranges the labels from the min and max of all series' do
        expect(labels.first).to eq '110'
        expect(labels.last).to eq '-50'
      end
    end

    describe 'given non-stacked series' do
      let(:stack?) { true }
      it 'ranges the labels from the cumulative min and max of all series' do
        expect(labels.first).to eq '130'
        expect(labels.last).to eq '-50'
      end
    end

    describe 'given :integer format' do
      let(:format) { :integer }
      it 'returns the labels as integers' do
        expect(labels).to eq %w(110 70 30 -10 -50)
      end
    end

    describe 'given :percentage format' do
      let(:format) { :percentage }
      it 'returns the labels as percentages with 1 significant digit' do
        expect(labels).to eq %w(110.0% 70.0% 30.0% -10.0% -50.0%)
      end
    end

    describe 'given :currency format' do
      let(:format) { :currency }
      it 'returns the labels as currency with 2 significant digits' do
        expect(labels).to eq %w($110.00 $70.00 $30.00 -$10.00 -$50.00)
      end
    end

    describe 'given :second format' do
      let(:format) { :seconds }
      it 'returns the labels as minutes:seconds' do
        expect(labels).to eq %w(1:50 1:10 0:30 -0:10 -0:50)
      end
    end

    describe 'given :float format' do
      let(:format) { :float }
      it 'returns the labels as floats with all significant digits' do
        expect(labels).to eq %w(110.0 70.0 30.0 -10.0 -50.0)
      end
    end
  end

  describe '#width' do
    let(:width) { axis.width }

    describe 'given no block, returns 0' do
      subject(:axis) { Squid::Axis.new series, options }
      it { expect(width).to be_zero }
    end

    describe 'given no block, returns the maximum value of the block' do
      subject(:axis) { Squid::Axis.new series, options, &block }
      let(:block) { -> (value) { value.to_i } }
      it { expect(width).to eq 110 }
    end
  end
end
