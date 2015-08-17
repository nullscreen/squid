require 'squid/base'

module Squid
  # Adds a legend to the graph. The legend is drawn in a floating bounding box
  # at the top of the graph, in the right side. The dimensions of the legend
  # are fixed: height, width and font size cannot be customized.
  # When multiple series are provided, the legend includes all of them, ordered
  # from the right to the left.
  class Legend < Base

    def draw
      bounding_box [left, bounds.top], width: width, height: legend_height do
        each_series do |x, series, color|
          x = draw_label series, x
          x = draw_square series, x, color
        end
      end
    end

  private

    def each_series
      x = bounds.right
      data.reverse_each.with_index do |series, index|
        x = yield x, series, @settings[:colors][data.size - index - 1]
        x -= label_padding
      end
    end

    # Writes the name of the series, left-aligned, with a small font size.
    # @param [Symbol, String] series The series to add to the legend
    # @param [Integer] x The current right-margin of the legend
    # @return [Integer] The updated right-margin (after adding the label)
    def draw_label(series, x)
      label = series.to_s.titleize
      x -= width_of(label, size: font_size).ceil
      options = {size: font_size, height: legend_height, valign: :center}
      text_box label, options.merge(at: [x, bounds.top])
      x
    end

    # Draws a square with the same color of the series (next to the label).
    # @param [Symbol, String] series The series to add to the legend
    # @param [Integer] x The current right-margin of the legend
    # @return [Integer] The updated right-margin (after adding the label)
    def draw_square(series, x, color)
      x -= square_size + square_padding
      with fill_color: color do
        fill_rectangle [x, bounds.height-square_size], square_size, square_size
      end
      x
    end

    # Restrict the legend to the right part of the graph
    def left
      bounds.width/2
    end

    # Restrict the legend to the right part of the graph
    def width
      bounds.width/2 - @settings[:offset]
    end

    # Ensure the label fits in the height of the legend
    def font_size
      legend_height/2
    end

    # Ensure the square fits in the height of the legend
    def square_size
      legend_height/3
    end

    # The horizontal distance left between the labels of two series
    def label_padding
      legend_height
    end

    # The horizontal distance left between the squares of two series
    def square_padding
      legend_height/5
    end
  end
end
