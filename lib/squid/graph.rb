require 'squid/base'
require 'squid/graph/baseline'
require 'squid/graph/chart'
require 'squid/graph/grid'
require 'squid/graph/legend'

module Squid
  class Graph < Base
    has_settings :baseline, :format, :gridlines, :height, :legend, :ticks

    # Draws the graph.
    def draw
      bounding_box [0, cursor], width: bounds.width, height: height do
        Legend.new(pdf, data.keys).draw if legend
        Grid.new(pdf, labels, left: left).draw if grid
        Baseline.new(pdf, categories, left: left, ticks: ticks).draw if baseline
        Chart.new(pdf, first_series, chart_options).draw
      end if data.any?
    end

  private

    def chart_options
      min, max = min_max first_series
      {left: left, min: min, max: max}
    end

    def first_series
      data.values.first.values
    end

    # Returns the categories to print below the baseline.
    def categories
      data.values.first.keys
    end

    # Returns the width of the left axis
    def left
      @left ||= max_width_of left_labels
    end

    # Returns the labels to print in the left axis.
    def left_labels
      @left_labels ||= labels_for first_series
    end

    # Returns the labels to print on both axes.
    def labels
      @labels ||= left_labels.map{|v| {left: v}}
    end

    # Returns the width of the longest label in the given font size.
    def max_width_of(labels)
      labels.map{|label| width_of label, size: font_size}.max
    end

    # Transform a numeric value into a label according to the given format.
    def labels_for(values)
      min, max = min_max values
      gap = (min - max)/gridlines.to_f
      max.step(by: gap, to: min).map{|value| format_for value}
    end

    # Returns the minimum and maximum value, approximated to significant digits.
    def min_max(values)
      min = (values + [0]).compact.min
      max = (values + [gridlines]).compact.max
      [min, max].map{|value| approximate_value_for value}
    end

    # Returns an approximation of a value that looks nicer on a graph axis.
    # For instance, rounds 99.67 to 100, which makes for a better axis value.
    def approximate_value_for(value)
      options = {significant: true, precision: 2}
      number_to_rounded(value, options).to_f
    end

    # Returns the formatted value (currency, percentage, ...).
    def format_for(value)
      case format
      when :percentage
        number_to_percentage value, precision: 1
      when :currency
        number_to_currency value
      else
        value
      end.to_s
    end

    # Returns whether the grid should be drawn at all.
    def grid
      gridlines > 0
    end
  end
end
