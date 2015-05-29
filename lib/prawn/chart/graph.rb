require 'prawn/chart/axis_value'
require 'prawn/chart/category'
require 'prawn/chart/graph_value'
require 'prawn/chart/gridline'
require 'prawn/chart/legend'

module Prawn
  module Chart
    class Graph < Base
      AXIS_WIDTH = 50
      LINES = 4

      def draw
        bounding_box [0, pdf.cursor], width: bounds.width, height: height do
          draw_legend
          draw_y_grid
          draw_y_axis
          draw_categories
          draw_graph
          draw_baseline
          stroke_bounds # TEMPORARY
        end
      end

    private

      def draw_legend
        options = {colors: colors, offset: legend_offset}
        Legend.new(pdf, data.keys, options).draw
      end

      def draw_y_grid
        each_gridline do |options = {}|
          Gridline.new(pdf, maximum_values, options).draw
        end
      end

      def draw_y_axis
        each_gridline do |options = {}|
          options.merge! format: format, two_axis: two_axis?
          AxisValue.new(pdf, maximum_values, options).draw
        end
      end

      # Note: This must come after draw_graph to draw the line on top
      def draw_baseline
        return unless data.any?
        stroke_horizontal_line AXIS_WIDTH, graph_width+AXIS_WIDTH, at: baseline
      end

      def maximum_values
        data.values.map do |series|
          max = series.values.max
          number_with_precision(max, significant: true, precision: 2).to_f
        end
      end

      def each_gridline
        0.upto(LINES) do |i|
          y = bounds.top - graph_height*i/LINES
          part = (LINES-i)/LINES.to_f
          yield axis_width: AXIS_WIDTH, width: graph_width, y: y, fraction: part
        end
      end

      def draw_graph
        each_category do |key, series, i, options = {}|
          options[:last_value] = series.values[i - 1] unless i.zero?
          GraphValue.new(pdf, {value: series[key]}, options).draw
        end
      end

      def draw_categories
        each_category(limit: 1, every: every) do |key, _, _, options = {}|
          options.merge! h: TEXT_HEIGHT, ticks: ticks
          Category.new(pdf, {label: key.to_s}, options).draw
        end
      end

      def each_category(limit: nil, every: 1)
        values = limit ? data.values.first(limit) : data.values
        values.each.with_index do |series, series_i|
          height_per_unit = graph_height/maximum_values[series_i]
          options = {y: baseline, height_per_unit: height_per_unit}
          options.merge! series_count: values.size, y: baseline, type: type
          options.merge! w: graph_width/series.keys.size, series_i: series_i

          (slices = series.keys.each_slice every).with_index do |keys, i|
            options[:x] = AXIS_WIDTH + options[:w]*i*every
            options[:color] = colors[series_i].next
            options[:line_width] = line_widths[series_i]
            yield keys.first, series, i, options
          end
        end
      end

      def graph_height
        bounds.height - TEXT_HEIGHT
      end

      def graph_width
        bounds.width - AXIS_WIDTH * (two_axis? ? 2 : 1)
      end

      def height
        settings.fetch :height, 200
      end

      def format
        settings.fetch :format, :number
      end

      def type
        settings.fetch :type, :column
      end

      def ticks
        settings.fetch :ticks, false
      end

      def colors
        @colors ||= settings.fetch(:colors, default_colors).map do |i|
          Array.wrap(i).cycle
        end
      end

      def line_widths
        settings.fetch :line_widths, Hash.new{1}
      end

      def every
        settings.fetch :every, 1
      end

      def legend_offset
        settings.fetch :legend_offset, -20
      end

      def two_axis?
        type == :two_axis
      end

      def baseline
        cursor - graph_height
      end
    end
  end
end
