require 'squid/base'

module Squid
  module Chart
    # Adds the chart components (columns, lines, ...) to the graph.
    class Base < Squid::Base
      def draw
        x = left
        data.each do |value|
          draw_element value, x
          draw_value_label value, x if @settings[:labels]
          x += width
        end
      end

    private

      # Writes the actual value number on top of the chart element.
      def draw_value_label(value, x)
        options = {at: [x+element_padding, text_height+label_padding+y(value)]}
        options.merge! width: width - 2 * element_padding, height: text_height
        options.merge! align: :center, valign: :bottom
        formatted_text_box [label_options(value)], options
      end


      def with_transparent_color
        with fill_color: @settings[:color] do
          transparent(0.95) { yield }
        end
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

      # Returns the vertical space between value label and element.
      def label_padding
        2
      end

      # Text options for the value labels
      def label_options(value)
        options = {size: font_size * 1.2, styles: [:bold]}
        options.merge! text: format_for(value, @settings[:format])
        options.merge! color: (value < 0 ? 'ffffff' : '000000')
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
end