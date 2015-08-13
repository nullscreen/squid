require 'squid/chart/base'

module Squid
  module Chart
    # Adds a point chart to the graph.
    class Point < Base
    private
      # Draws a single point to represent a value of a series in the chart.
      def draw_element(value, x, width, options = {})
        fill_circle [x + width/2, y(value)], 5
      end
    end
  end
end
