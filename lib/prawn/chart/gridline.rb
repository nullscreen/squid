require 'prawn/chart/base'

module Prawn
  module Chart
    class Gridline < Base
      def draw
        return unless visible?

        transparent(0.25) do
          x2 = settings[:w] - (settings[:two_axis] ? settings[:x1] : 0)
          stroke_horizontal_line settings[:x1], x2, at: settings[:y]
        end
      end
    end
  end
end
