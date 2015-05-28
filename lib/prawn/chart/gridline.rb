require 'prawn/chart/base'

module Prawn
  module Chart
    class Gridline < Base
      def draw
        return unless visible?
        transparent(0.25) { with(:line_width, 0.5) { draw_line } }
      end

    private

      def draw_line
        x2 = settings[:width] + settings[:axis_width]
        stroke_horizontal_line settings[:axis_width], x2, at: settings[:y]
      end
    end
  end
end
