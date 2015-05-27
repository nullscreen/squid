require 'prawn/chart/base'

module Prawn
  module Chart
    class Legend < Base
      def draw
        return unless visible?

        x_offset = settings.fetch :x_offset, -20
        x, y, w, h, size = bounds.width + x_offset, cursor + 25, 45, 15, 5

        data.each.with_index do |series_name, i|
          label = series_name.to_s.titleize
          options = {size: size + 2, align: :right, width: w, height: h}
          text_box label, options.merge(at: [x-48-i*(w+20), y])
          draw_square [x-i*(w+20), y], size, series_colors[i]
        end
      end

    private

      def draw_square(origin, size, color)
        with :fill_color, color do
          stroke { fill_rectangle origin, size, size }
        end
      end

      def series_colors
        %w(ff0000 00ff00 0000ff)
      end
    end
  end
end
