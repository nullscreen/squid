require 'prawn/chart/base'
require 'prawn/chart/legend'
require 'prawn/chart/gridline'
require 'prawn/chart/axis_value'

module Prawn
  module Chart
    class Graph < Base
      def draw
        x, y, w, h = 0, pdf.cursor, bounds.width, settings.fetch(:height, 200)

        bounding_box [x, y], width: w, height: h do
          draw_legend
          draw_y_grid
          draw_y_axis
        end
      end

    private

      def draw_legend
        Legend.new(pdf, data.keys, settings.fetch(:legend, {})).draw
      end

      def draw_y_grid
        each_gridline do |options = {}|
          Gridline.new(pdf, series_limits, options).draw
        end
      end

      def draw_y_axis
        each_gridline do |options = {}|
          AxisValue.new(pdf, series_limits, options).draw
        end
      end

      def series_limits
        data.values.map{|series| series.values.max}
      end

      def each_gridline
        lines = 4
        options = {x1: 50, w: bounds.width, left: bounds.left}
        options[:two_axis] = settings.fetch(:type, :column) == :two_axis
        options[:format] = settings.fetch :format, :number

        0.upto(lines) do |i|
          y = cursor - i*bounds.height/(lines+1)
          yield options.merge(y: y, fraction: (lines-i)/lines.to_f)
        end
      end
    end
  end
end
