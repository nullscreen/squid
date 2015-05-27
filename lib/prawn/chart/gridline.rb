require 'prawn/chart/base'

module Prawn
  module Chart
    class Gridline < Base
      def draw
        return unless visible?

        if settings[:fraction].zero?
          draw_line
        else
          transparent(0.25) { with(:line_width, 0.5) { draw_line } }
        end
      end

    private

      def draw_line
        x2 = settings[:w] - (settings[:two_axis] ? settings[:x1] : 0)
        stroke_horizontal_line settings[:x1], x2, at: settings[:y]
      end
    end
  end
end
