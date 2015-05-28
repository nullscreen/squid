require 'prawn/chart/base'

module Prawn
  module Chart
    class GraphValue < Base
      def draw
        h = data[:value]*settings[:height_per_unit]
        w = settings[:w] - 2*padding

        with :fill_color, settings[:color] do
          stroke { fill_rectangle [settings[:x]+padding, settings[:y]+h], w, h }
        end
      end
    end
  end
end
