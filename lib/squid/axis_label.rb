module Squid
  class AxisLabel
    def self.for(axis, height:, align:)
      height.step(0, -height/(axis.labels.size-1).to_f).map.with_index do |y, i|
        new y: y, label: axis.labels[i], align: align, width: axis.width
      end
    end

    attr_reader :label, :y, :align, :width

    def initialize(label:, y:, align:, width:)
      @label, @y, @align, @width = label, y, align, width
    end
  end
end
