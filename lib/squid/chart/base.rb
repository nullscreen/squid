require 'squid/base'

module Squid
  module Chart
    # Adds the chart components (columns, lines, ...) to the graph.
    class Base < Squid::Base
      def draw
        data.each.with_index do |values, index|
          draw_series values, index: index, count: data.size
        end
      end

    private

      def draw_series(series, options = {})
        x = left
        series.each.with_index do |value, index|
          options[:previous_value] = (series[index - 1] if index > 0)
          with_transparent_color options[:index] do
            draw_element h(value), x, w(series), options
          end
          draw_label value, x, w(series), options if @settings[:labels]
          x += w(series)
        end
      end

      # To be overriden by subclasses
      def draw_element(h, x, w, options = {})
      end

      # Writes the actual value number on top of the chart element.
      def draw_label(value, x, w, options = {})
        label_x, label_width = label_position x, w, options
        options = {align: :center, valign: :bottom, height: text_height}
        options[:width] = label_width
        options[:at]= [label_x, text_height + label_padding + label_y(value)]
        formatted_text_box [label_options(value)], options
      end

      # To be overriden by subclasses
      def label_position(x, w, options = {})
        [x, w]
      end

      def label_y(value)
        h(value) + zero_y
      end

      def with_transparent_color(index)
        color = @settings[:colors][index]
        with fill_color: color, stroke_color: color do
          transparent(0.95) { yield }
        end
      end

      # Returns the leftmost point of the chart.
      def left
        @settings[:left] + padding
      end

      # Return the horizontal space available for each element of a series.
      def w(series)
        (bounds.right - left) / series.size.to_f
      end

      # Returns the vertical space between value label and element.
      def label_padding
        3
      end

      # Text options for the value labels
      def label_options(value)
        options = {size: font_size * 1.2, styles: [:bold]}
        options.merge! text: format_for(value, @settings[:format])
      end

      # Return the height for a value element
      def h(value)
        height_per_unit * value.to_f
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