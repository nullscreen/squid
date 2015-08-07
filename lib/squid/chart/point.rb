require 'squid/chart/base'

module Squid
  module Chart
    # Adds a point chart to the graph.
    class Point < Base
    private
      # Draws a single point to represent the
      # value in the chart. Adds some padding to separate between elements.
      def draw_element(value, x, options = {})
        with_transparent_color do
          fill_circle [x + width / 2, y(value)], 5
        end
      end
    end
  end
end
