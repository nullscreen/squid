require 'squid/base'
require 'squid/chart/column'
require 'squid/chart/line'
require 'squid/chart/point'
require 'squid/chart/stack'
require 'squid/graph/baseline'
require 'squid/graph/grid'
require 'squid/graph/legend'

module Squid
  class Graph < Base
    has_settings :baseline, :border, :chart, :colors, :every, :format, :height
    has_settings :legend, :line_width, :steps, :ticks, :type, :labels

    # Draws the graph.
    def draw
      bounding_box [0, cursor], width: bounds.width, height: height do
        draw_graph
      end if data.any?
    end

  private

    def draw_graph
      draw_legend if legend
      draw_grid if grid
      draw_chart if chart
      draw_baseline if baseline
      draw_border if border
    end

    def draw_legend
      Legend.new(pdf, data.keys, colors: colors, offset: legend_offset).draw
    end

    def draw_grid
      Grid.new(pdf, axis_labels, grid_options.merge(baseline: baseline)).draw
    end

    def draw_baseline
      Baseline.new(pdf, categories, left: left, ticks: ticks, every: every).draw
    end

    def draw_chart
      min, max = min_max all_series
      options = grid_options.merge min: min, max: max, labels: labels
      options.merge! format: format, colors: colors
      options.merge! line_width: line_width if type == :line
      chart_class.new(pdf, all_series, options).draw
    end

    def chart_class
      case type
        when :stack then Chart::Stack
        when :column then Chart::Column
        when :line then Chart::Line
        when :point then Chart::Point
      end
    end

    def grid_options
      {left: left, height: chart_height, top: chart_top}
    end

    def draw_border
      with(line_width: 0.5) { stroke_bounds }
    end

    # @return [Array<Array>] the array of values for each series.
    def all_series
      data.values.map &:values
    end

    # Returns the categories to print below the baseline.
    def categories
      data.values.first.keys
    end

    # Returns the width of the left axis
    def left
      @left ||= max_width_of left_axis_labels
    end

    def chart_height
      bounds.height - padding_top - padding_bottom
    end

    def chart_top
      bounds.top - padding_top
    end

    # Return the padding between the top of the graph and the grid.
    # In any case, a padding is present (for values above the top of the grid).
    # If there is a legend, an equivalent padding is present for the legend.
    def padding_top
      legend_height * (legend ? 2 : 1)
    end

    # Return the padding between the grid and the bottom of the graph.
    # It is only present if baseline and categories are drawn
    def padding_bottom
      baseline ? text_height : 0
    end

    # Returns the labels to print in the left axis.
    def left_axis_labels
      @left_axis_labels ||= axis_labels_for all_series
    end

    # Returns the labels to print on both axes.
    def axis_labels
      @axis_labels ||= left_axis_labels.map{|v| {left: v}}
    end

    # Returns the width of the longest label in the given font size.
    def max_width_of(axis_labels)
      axis_labels.map{|label| width_of label, size: font_size}.max
    end

    # Transform a numeric value into a label according to the given format.
    def axis_labels_for(values)
      min, max = min_max values
      gap = (min - max)/steps.to_f
      max.step(by: gap, to: min).map{|value| format_for value, format}
    end

    # Returns the minimum and maximum value, approximated to significant digits.
    # @param [Array<Array>] the array of values for each series.
    def min_max(array_of_values)
      min_values, max_values = extract_min_max(array_of_values, type == :stack)
      min = (min_values + [0]).compact.min
      max = (max_values + [steps]).compact.max
      [min, max].map{|value| approximate_value_for value}
    end

    def extract_min_max(array_of_values, stacked)
      if stacked
        transposed_array = array_of_values.transpose
        transposed_array.map{|a| a.partition{|n| n < 0}.map(&:sum)}.transpose
      else
        [array_of_values.flatten] * 2
      end
    end

    # Returns an approximation of a value that looks nicer on a graph axis.
    # For instance, rounds 99.67 to 100, which makes for a better axis value.
    def approximate_value_for(value)
      number_to_rounded(value, significant: true, precision: 2).to_f
    end

    # Returns whether the grid should be drawn at all.
    def grid
      steps > 0
    end

    # Returns the padding to leave between legend and right margin
    def legend_offset
      legend.is_a?(Hash) ? legend.fetch(:offset, 0) : 0
    end
  end
end
