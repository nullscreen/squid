require 'squid/base'
require 'squid/graph/axis_value'
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
          AxisValue.new(pdf, max_min_values, options).draw
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

    # Returns the maximum and minimum values of each series.
    def max_min_values
      data.values.map do |series|
        max = (series.values + [gridlines]).compact.max
        min = (series.values + [0]).compact.min
        [max, min].map{|value| approximate_value_for value}
      end
    end

    # Returns an approximation of a value that looks nicer on a graph axis.
    # For instance, rounds 99.67 to 100, which makes for a better axis value.
    def approximate_value_for(value)
      options = {significant: true, precision: 2}
      ActiveSupport::NumberHelper.number_to_rounded(value, options).to_f
    end
  end
end
