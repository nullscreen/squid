require 'squid/chart/base'

module Squid
  module Chart
    # Adds a column chart to the graph.
    class Column < Base
    private
      # Draws a single column to represent the
      # value in the chart. Adds some padding to separate between elements.
      def draw_element(value, x)
        w = width - 2 * element_padding
        with_transparent_color do
          fill_rectangle [x + element_padding, y(value)], w, y(value) - zero_y
        end
      end
    end
  end
end
