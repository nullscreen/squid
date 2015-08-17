require 'squid/base'

module Squid
  # Adds a baseline to the graph. It’s drawn last and separately from the
  # grid lines so it can be on top of any other graph element. The categories
  # are written below the baseline, optionally with ticks.
  class Baseline < Base

    def draw
      x = left
      data.each.with_index do |category, index|
        draw_tick x if @settings[:ticks]
        draw_category category, x if (index % @settings[:every]).zero?
        x += width
      end
      draw_baseline
    end

  private

    # Draws the solid line.
    def draw_baseline
      stroke_horizontal_line left, bounds.right, at: y
    end

    # Draws a vertical tick between baseline and category label.
    def draw_tick(x)
      stroke_vertical_line y, y - tick_height, at: x + width/2
    end

    # Writes the category label below the line.
    def draw_category(category, x)
      category_options = {height: text_height, width: width, size: font_size}
      category_options.merge! align: :center, at: [x, y]
      category_options.merge! disable_wrap_by_char: true #, leading: -3 ???
      text_box category.to_s, text_options.merge(category_options)
    end

    # Returns the leftmost point of the baseline.
    def left
      @settings[:left] + padding
    end

    # Returns the horizontal space for each category.
    def width
      (bounds.right - left) / data.size.to_f
    end

    # Returns the vertical position of the baseline.
    def y
      bounds.bottom + text_height
    end

    # Returns the height of the tick
    def tick_height
      2
    end
  end
end
