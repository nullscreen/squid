require 'squid/graph'

module Squid
  module Interface
    def chart(settings = {})
      Graph.new(self, settings).draw
    end
  end
end

Prawn::Document.extensions << Squid::Interface
