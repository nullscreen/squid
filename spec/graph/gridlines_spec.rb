require 'spec_helper'

describe 'Graph gridlines', inspect: true do
  let(:options) { {baseline: false} }

  specify 'given no series, are not printed' do
    pdf.chart no_series, options
    expect(inspected_line.points).to be_empty
  end

  context 'given one or more series' do
    before { pdf.chart [one_series, two_series].sample, options }

    specify 'are 5 equidistant horizontal lines along the height of the graph' do
      left_point = inspected_points.map{|x| x.first.first}
      expect(left_point.uniq).to be_one

      right_point = inspected_points.map{|x| x.last.first}
      expect(right_point.uniq).to be_one

      orientation = inspected_points.map{|x| x.first.last - x.last.last}
      expect(orientation).to all (eq 0)

      distance = inspected_points.each_cons(2).map do |x|
        x.first.first.last - x.last.first.last
      end
      expect(distance.uniq).to be_one
    end
  end

  it 'can be set with the :steps option' do
    pdf.chart one_series, options.merge(steps: 8)
    expect(inspected_points.size).to be 9
  end

  it 'can be set with Squid.config' do
    Squid.configure {|config| config.steps = 6}
    pdf.chart one_series, options
    Squid.configure {|config| config.steps = 4}

    expect(inspected_points.size).to be 7
  end
end
