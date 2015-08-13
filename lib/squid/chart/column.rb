require 'squid/chart/base'

module Squid
  module Chart
    # Adds a column chart to the graph.
    class Column < Base
    private
      # Draws a single column to represent a value of a series in the chart.
      # Adds some padding to separate between elements.
      def draw_element(value, x, width, options = {})
        w = item_width_for width, options[:count]
        offset = padding_for(width) + options[:index] * w
        fill_rectangle [x + offset, y(value)], w, y(value) - zero_y
      end

      # Draw white labels if on top of a column.
      def label_options(value)
        super(value).merge! color: (value < 0 ? 'ffffff' : '000000')
      end

      # Draw labels on top of each column.
      def label_position(x, w, options = {})
        width = item_width_for w, options[:count]
        [x + padding_for(w) + width * options[:index], width]
      end

      def padding_for(width)
        width / 8
      end

      def item_width_for(width, count)
        (width - 2 * padding_for(width)) / count
      end
    end
  end
end
