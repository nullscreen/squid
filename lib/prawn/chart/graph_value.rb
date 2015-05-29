require 'prawn/chart/base'

module Prawn
  module Chart
    class GraphValue < Base
      def draw
        h = data[:value]*settings[:height_per_unit]
        case settings[:type]
        when :column
          draw_columns(h)
        when :line
          draw_lines(h)
        when :two_axis
          settings[:series_i].zero? ? draw_single_column(h) : draw_lines(h)
        end
      end

    private

      def draw_lines(h)
        return unless settings[:last_value]
        last_x = settings[:x]-settings[:w]/2
        last_y = settings[:y] + settings[:last_value]*settings[:height_per_unit]

        with stroke_color: settings[:color], cap_style: :round, line_width: settings[:line_width] do
          line [last_x, last_y], [last_x + settings[:w], settings[:y]+h]
        end
      end

      def draw_single_column(h)
        w = settings[:w] - 2*padding
        draw_rectangle settings[:x] + padding, w, h
      end

      def draw_columns(h)
        w = (settings[:w] - 2*padding)/settings[:series_count].to_f
        offset = padding + w*settings[:series_i]
        draw_rectangle settings[:x] + offset, w, h
      end

      def draw_rectangle(x, w, h)
        with fill_color: settings[:color] do
          fill_rectangle [x, settings[:y] + h], w, h
        end
      end
    end
  end
end
