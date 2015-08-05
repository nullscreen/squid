require 'squid/base'

module Squid
  # Adds a legend to the graph. The legend is drawn in a floating bounding box
  # at the top of the graph, in the right side. The dimensions of the legend
  # are fixed: height, width and font size cannot be customized.
  # When multiple series are provided, the legend includes all of them, ordered
  # from the right to the left.
  class Legend < Base

    def draw
      float do
        bounding_box [width, cursor+height*2], width: width, height: height do
          right_margin = bounds.right
          data.each do |series|
            right_margin = draw_label series, right_margin
            right_margin = draw_square series, right_margin
            right_margin -= label_padding
          end
        end
      end
    end

  private

    # Writes the name of the series, left-aligned, with a small font size.
    # @param [Symbol, String] series The series to add to the legend
    # @param [Integer] x The current right-margin of the legend
    # @return [Integer] The updated right-margin (after adding the label)
    def draw_label(series, x)
      label = series.to_s.titleize
      x -= width_of label, size: font_size
      text_box label, at: [x, bounds.top], size: font_size, height: height, valign: :center
      x
    end

    # Draws a square with the same color of the series (next to the label).
    # @param [Symbol, String] series The series to add to the legend
    # @param [Integer] x The current right-margin of the legend
    # @return [Integer] The updated right-margin (after adding the label)
    def draw_square(series, x)
      x -= square_size + square_padding
      fill_rectangle [x, bounds.height - square_size], square_size, square_size
      x
    end

    # Restrict the legend to the right part of the graph
    def width
      bounds.width/2
    end

    # Restrict the legend to a specific vertical space
    def height
      15
    end

    # Ensure the label fits in the height of the legend
    def font_size
      height/2
    end

    # Ensure the square fits in the height of the legend
    def square_size
      height/3
    end

    # The horizontal distance left between the labels of two series
    def label_padding
      height
    end

    # The horizontal distance left between the squares of two series
    def square_padding
      height/5
    end
  end
end
