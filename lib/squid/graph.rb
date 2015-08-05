require 'squid/base'
require 'squid/graph/gridline'
require 'squid/graph/legend'

module Squid
  class Graph < Base
    has_settings :baseline, :gridlines, :height, :legend

    # Draws the graph.
    def draw
      bounding_box [0, cursor], width: bounds.width, height: height do
        Legend.new(pdf, data.keys).draw if legend

        each_gridline do |options = {}|
          Gridline.new(pdf, {}, options).draw
        end

        # The baseline is last so it’s drawn on top of any graph element.
        stroke_horizontal_line 0, bounds.width, at: cursor - height if baseline
      end
    end

  private

    # Yields the block once for each gridline, setting +y+ appropriately.
    def each_gridline
      0.upto(gridlines) do |index|
        fraction = (gridlines - index) / gridlines.to_f
        y = bounds.top - height*index / gridlines
        yield width: bounds.width, y: y, fraction: fraction
      end if data.any? && gridlines > 0
    end
  end
end
