require 'prawn/chart/base'

module Prawn
  module Chart
    class GraphValue < Base
      def draw
        h = data[:value]*settings[:height_per_unit]
        case settings[:type]
          when :column then draw_column(h)
          when :line then draw_line(h)
        end
      end

    private

      def draw_column(h)
        w = settings[:w] - 2*padding
        with fill_color: settings[:color] do
          fill_rectangle [settings[:x]+padding, settings[:y]+h], w, h
        end
      end

      def draw_line(h)
        return unless settings[:last_value]
        last_x = settings[:x]-settings[:w]/2
        last_y = settings[:y] + settings[:last_value]*settings[:height_per_unit]

        with stroke_color: settings[:color], cap_style: :round, line_width: settings[:line_width] do
          line [last_x, last_y], [last_x + settings[:w], settings[:y]+h]
        end
      end
    end
  end
end
