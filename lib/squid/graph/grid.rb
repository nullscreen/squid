require 'squid/base'

module Squid
  # Adds all the gridlines and axis values to the graph.
  class Grid < Base
    def draw
      y = bounds.top
      data.each.with_index do |labels, index|
        draw_gridline y unless index == data.size - 1
        labels.each{|position, label| draw_label label, y, position}
        y -= bounds.height / (data.size - 1)
      end
    end

  private

    def draw_gridline(y)
      transparent(0.25) do
        with(line_width: 0.5) do
          left = width(:left) + label_padding(:left)
          right = bounds.right - width(:right) - label_padding(:right)
          stroke_horizontal_line left, right, at: y
        end
      end
    end

    def draw_label(label, y, position)
      label_options = {height: text_height, size: font_size}
      label_options[:width] = width position
      label_options[:align] = align position
      label_options[:at] = [delta(position), y + text_height / 2]
      text_box label, text_options.merge(label_options)
    end

    # If labels are wider than this, they will be shrunk to fit
    def max_width
      100
    end

    def align(position)
      position == :left ? :right : :left
    end

    def delta(position)
      position == :left ? bounds.left : bounds.right - width(position)
    end

    def width(position)
      [@settings.fetch(position, 0), max_width].min
    end

    # The horizontal space between the label and the gridline
    def label_padding(position)
      @settings.key?(position) ? padding : 0
    end
  end
end
