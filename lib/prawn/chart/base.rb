module Prawn
  module Chart
    class Base
      include ActionView::Helpers::NumberHelper

      attr_reader :pdf, :data, :settings

      def initialize(document, data = {}, settings = {})
        @pdf = document
        @data = data
        @settings = settings
      end

      def draw
      end

      # Delegates all unhandled calls to object returned by +pdf+ method.
      def method_missing(method, *args, &block)
        return super unless pdf.respond_to?(method)

        pdf.send(method, *args, &block)
      end

    private

      def visible?
        data.any? && settings
      end
    end
  end
end