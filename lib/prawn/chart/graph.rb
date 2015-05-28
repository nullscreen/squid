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
        Legend.new(pdf, data.keys, settings.fetch(:legend, {})).draw
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
        stroke_horizontal_line AXIS_WIDTH, graph_width+AXIS_WIDTH, at: baseline
      end

      def maximum_values
        data.values.map do |series|
          max = series.values.max
          number_with_precision(max, significant: true, precision: 2).to_f
        end
      end

      def each_gridline
        0.upto(LINES-1) do |i|
          y = bounds.top - graph_height*i/LINES
          part = (LINES-i)/LINES.to_f
          yield axis_width: AXIS_WIDTH, width: graph_width, y: y, fraction: part
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

      def two_axis?
        settings.fetch(:type, :column) == :two_axis
      end

      def format
        settings.fetch :format, :number
      end

      def draw_graph
        mark_last = settings.fetch(:categories, {}).fetch :mark_last, false

        each_category(mark_last: mark_last) do |series, key, options = {}|
          GraphValue.new(pdf, {value: series[key]}, options).draw
        end
      end

      def draw_categories
        every = settings.fetch(:categories, {}).fetch :every, 1
        ticks = settings.fetch(:categories, {}).fetch :ticks, false

        each_category(limit: 1, every: every) do |series, key, options = {}|
          options.merge! h: TEXT_HEIGHT, ticks: ticks
          Category.new(pdf, {label: key}, options).draw
        end
      end

      def each_category(limit: nil, every: 1, mark_last: false)
        values = limit ? data.values.first(limit) : data.values
        values.each.with_index do |series, series_i|
          w = graph_width/series.keys.size
          height_per_unit = graph_height/maximum_values[series_i]
          options = {y: baseline, height_per_unit: height_per_unit}

          (slices = series.keys).each_slice(every).with_index do |keys, i|
            x = AXIS_WIDTH + w*i*every
            highlight_i = mark_last && (slices.size - i - 1).zero? ? 1 : 0 
            color = series_colors[series_i + highlight_i]
            yield series, keys.first, options.merge(x: x, w: w, color: color)
           end
        end
      end

      def baseline
        cursor - graph_height
      end
    end
  end
end
