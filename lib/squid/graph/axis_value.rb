require 'squid/base'

module Squid
  # Adds a single value label to the axis of a graph. The :format option can
  # be used to specify the format of the label (currency, percentage, ...).
  class AxisValue < Base
    def draw
      text_box label, label_options
    end

  private

    # The label formats the value based on the :format option.
    def label
      value.to_s
    end

    def label_options
      text_options.merge height: height, at: [bounds.left, y]
    end

    # The actual value is calculated by considering the minimum and maximum
    # values for the axis and which value the label represents (fraction).
    def value
      max_value, min_value = @data.first
      (max_value - min_value) * @settings[:fraction] + min_value
    end

    # The vertical position where the value should be drawn.
    def y
      @settings[:y] + height/2
    end

    # The height of each axis label
    def height
      20
    end
  end
end
