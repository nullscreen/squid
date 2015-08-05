require 'spec_helper'

describe 'Graph gridlines', inspect: true do
  before { pdf.chart data, options.merge(baseline: false) }

  # context 'given no series, does not print any gridline' do
  #   it { expect(inspected_line.points).to be_empty }
  # end

  context 'given one or more series' do
    let(:data) { {views: views} }

    it 'draws 5 equidistant horizontal lines along the height of the graph' do
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

end
