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

    def draw
      bounding_box [0, pdf.cursor], width: bounds.width, height: height do
        stroke_bounds
      end
    end

    # Delegates all unhandled calls to object returned by +pdf+ method.
    def method_missing(method, *args, &block)
      return super unless pdf.respond_to?(method)
      pdf.send method, *args, &block
    end
  end
end