require 'squid/chart/base'

module Squid
  module Chart
    # Adds a stacked column chart to the graph.
    class Stack < Column
    private
      # Draws a single rectangle on the stack to represent a value of a series
      # in the chart.
      def draw_element(h, x, width, options = {})
        options = options.dup.merge! index: 0, count: 1, y: y(h, options)
        super
      end

      def y(h, options = {})
        @last_index ||= -1
        @index = 0 if options[:index] > @last_index
        y = if h > 0
          (@maxs ||= Hash.new(0))[@index] += h
        else
          (@mins ||= Hash.new(0))[@index] += h
        end
        @index += 1
        @last_index = options[:index]
        @last_y = y + zero_y
      end

      def label_y(value)
        @last_y
      end

      # Draw labels on top of each column.
      def label_position(x, w, options = {})
        [x + padding_for(w), item_width_for(w)]
      end
    end
  end
end
