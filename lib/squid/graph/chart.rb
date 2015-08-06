require 'squid/base'

module Squid
  # Adds the chart components (columns, lines, ...) to the graph.
  class Chart < Base

    def draw
      x = left
      data.each do |value|
        draw_element value, x
        x += width
      end
    end

  private

    # Draws a single element (one column, one point, ...) to represent the
    # value in the chart.
    def draw_element(value, x)
      fill_rectangle [x, zero_y + height(value)], width, height(value)
    end

    # Returns the leftmost point of the chart.
    def left
      @settings[:left] + padding
    end

    # Returns the horizontal space for each element.
    def width
      (bounds.right - left) / data.size.to_f
    end

    # Returns the vertical space for a given value.
    def height(value)
      height_per_unit * value.to_f
    end

    # Returns the vertical position for the "0" value.
    def zero_y
      baseline = cursor - bounds.height
      baseline - @settings[:min] * height_per_unit
    end

    # Returns how many points correspond to how many units of the value
    def height_per_unit
      @h_p_u ||= bounds.height.to_f / (@settings[:max] - @settings[:min])
    end
  end
end
