require 'squid/base'

module Squid
  # Adds a baseline to the graph. It’s drawn last and separately from the
  # grid lines so it can be on top of any other graph element.
  class Baseline < Base

    def draw
      left = @settings[:left] + padding
      y = cursor - @settings[:height]
      stroke_horizontal_line left, bounds.right, at: y
    end
  end
end
