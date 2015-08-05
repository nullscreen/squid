require 'squid/settings'

module Squid
  class Graph
    extend Settings
    has_settings :height

    attr_reader :pdf

    def initialize(document, settings = {})
      @pdf = document
      @settings = settings
    end

    # Draws the graph.
    def draw
      bounding_box [0, cursor], width: bounds.width, height: height do
        draw_baseline
      end
    end

    # Delegates all unhandled calls to object returned by +pdf+ method.
    def method_missing(method, *args, &block)
      return super unless pdf.respond_to?(method)
      pdf.send method, *args, &block
    end

  private

    # Draws the baseline of a graph.
    # Must run after draw_graph in order to draw the line on top of the graph.
    def draw_baseline
      stroke_horizontal_line 0, bounds.width, at: cursor - height
    end
  end
end