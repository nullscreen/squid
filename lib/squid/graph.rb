require 'squid/base'
require 'squid/graph/legend'

module Squid
  class Graph < Base
    has_settings :height

    # Draws the graph.
    def draw
      bounding_box [0, cursor], width: bounds.width, height: height do
        Legend.new(pdf, data.keys).draw

        # The baseline is last so it’s drawn on top of any graph element.
        stroke_horizontal_line 0, bounds.width, at: cursor - height
      end
    end

  private

  end
end
