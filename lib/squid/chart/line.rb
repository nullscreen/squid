require 'squid/chart/base'

module Squid
  module Chart
    # Adds a line chart to the graph.
    class Line < Base
    private
      # Draws a single line to represent the
      # value in the chart. Adds some padding to separate between elements.
      def draw_element(value, x, options = {})
        return unless previous_value = options[:previous_value]

        with_transparent_color do
          with cap_style: :round, line_width: @settings[:line_width] do
            line [x - width / 2, y(previous_value)], [x + width / 2, y(value)]
          end
        end
      end
    end
  end
end
