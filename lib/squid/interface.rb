require 'squid/graph'

module Squid
  module Interface
    def chart(data =  {}, settings = {})
      Graph.new(self, data, settings).draw
    end
  end
end

Prawn::Document.extensions << Squid::Interface
