require 'prawn/chart/base'

module Prawn
  module Chart
    class Legend < Base
      def draw
        return unless visible?
        x, y, w, h, size = bounds.width + settings[:offset], cursor + 25, 45, 15, 5

        data.each.with_index do |series_name, i|
          label = series_name.to_s.titleize
          options = {size: size + 2, align: :right, width: w, height: h}
          text_box label, options.merge(at: [x-48-i*(w+20), y])
          draw_square [x-i*(w+20), y], size, settings[:colors][i].first
        end
      end

    private

      def draw_square(origin, size, color)
        with fill_color: color do
          fill_rectangle origin, size, size
        end
      end
    end
  end
end
