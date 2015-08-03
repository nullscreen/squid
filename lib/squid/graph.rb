module Squid
  class Graph
    def self.has_settings(*settings)
      settings.each do |setting|
        define_method setting do # make private
          @settings.fetch setting, 200 # replace 200 with Squid.configuration.setting
        end
      end
    end

    attr_reader :pdf
    has_settings :height

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