require 'prawn/chart/base'

module Prawn
  module Chart
    class AxisValue < Base
      def draw
        return unless visible?
        draw_label_one label_for(data.last)
        draw_label_two label_for(data.first) if settings[:two_axis]
      end

    private

      def label_for(max_value)
        value = max_value*settings[:fraction]
        case settings[:format]
          when :number then number_with_delimiter value.to_i
          when :percentage then number_to_percentage value, precision: 1
        end
      end

      def draw_label_one(label)
        draw_label label, bounds.left, align: :right, width: label_width
      end

      def draw_label_two(label)
        left = settings[:width] + settings[:axis_width] + padding
        draw_label label, left, align: :left, width: label_width
      end

      def draw_label(label, left, options = {})
        options.reverse_merge! text_options
        x2 = settings[:y] + options[:height]/2
        text_box label, options.merge(at: [left, x2])
      end

      def label_width
        settings[:axis_width] - padding
      end
    end
  end
end
