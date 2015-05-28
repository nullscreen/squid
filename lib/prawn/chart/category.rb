require 'prawn/chart/base'

module Prawn
  module Chart
    class Category < Base
      def draw
        options = text_options.merge(align: :center)
        options.merge! width: (settings[:w]), height: settings[:h]

        if settings[:ticks]
          x = settings[:x] + settings[:w]/2
          stroke_vertical_line settings[:y], settings[:y] - 2, at: x
        end

        text_box data[:label], options.merge(at: [settings[:x], settings[:y]])
      end
    end
  end
end
