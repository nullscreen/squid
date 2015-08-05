require 'squid/base'

module Squid
  # Adds a single gridline to the graph. The gridline spans the whole width
  # of the graph. The vertical position of the gridline is determined by how
  # many gridlines are configured. The line width cannot be customized.
  # The last gridline is skipped since it would be overwritten by the baseline.
  class Gridline < Base
    def draw
      return if @settings[:fraction].zero?
      transparent(0.25) { with(line_width: 0.5) { draw_line } }
    end

  private

    def draw_line
      stroke_horizontal_line bounds.left, @settings[:width], at: @settings[:y]
    end
  end
end
