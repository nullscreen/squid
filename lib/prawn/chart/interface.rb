require 'prawn/chart/graph'

module Prawn
  module Chart
    module Interface
      def chart(data = {}, settings = {})
        Graph.new(self, data, settings).draw
      end
    end
  end
end

Prawn::Document.extensions << Prawn::Chart::Interface
