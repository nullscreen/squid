require 'squid/base'

module Squid
  # Adds the chart components (columns, lines, ...) to the graph.
  class Chart < Base
    def draw
      x = left
      data.each do |value|
        draw_element value, x
        draw_value_label value, x if @settings[:labels]
        x += width
      end
    end

  private

    # Draws a single element (one column, one point, ...) to represent the
    # value in the chart. Adds some padding to separate between elements.
    def draw_element(value, x)
      w = width - 2 * element_padding
      fill_rectangle [x + element_padding, y(value)], w, y(value) - zero_y
    end

    # Writes the actual value number on top of the chart element.
    def draw_value_label(value, x)
      label = format_for value, @settings[:format]
      options = {height: text_height, size: font_size, style: :bold}
      options.merge! align: :center, width: width - 2 * element_padding
      options.merge! at: [x + element_padding, text_height + y(value)]
      text_box label, text_options.merge(options)
    end

    # Returns the leftmost point of the chart.
    def left
      @settings[:left] + padding
    end

    # Returns the horizontal space for each element.
    def width
      (bounds.right - left) / data.size.to_f
    end

    # Returns the horizontal space between elements.
    def element_padding
      width / 8
    end

    # Return the vertical position for a value
    def y(value)
      zero_y + height_per_unit * value.to_f
    end

    # Returns the vertical position for the "0" value.
    def zero_y
      @settings[:top] - @settings[:height] - @settings[:min] * height_per_unit
    end

    # Returns how many points correspond to how many units of the value
    def height_per_unit
      @h_p_u ||= @settings[:height].to_f / (@settings[:max] - @settings[:min])
    end
  end
end
