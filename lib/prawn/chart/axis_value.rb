require 'prawn/chart/base'

module Prawn
  module Chart
    class AxisValue < Base
      def draw
        return unless visible?

        maximum_values = data.map do |max|
          number_with_precision(max, significant: true, precision: 2).to_i
        end

        w = settings[:x1] - 5 # padding
        draw_label_one label_for(maximum_values.first), w
        draw_label_two label_for(maximum_values.last), w if settings[:two_axis]
      end

    private

      def label_for(max_value)
        value = max_value*settings[:fraction]
        case settings[:format]
          when :number then number_with_delimiter value.to_i
          when :percentage then number_to_percentage value, precision: 1
        end
      end

      def draw_label_one(label, width)
        draw_label label, settings[:left], align: :right, width: width
      end

      def draw_label_two(label, width)
        draw_label label, settings[:w] - width, align: :left, width: width
      end

      def draw_label(label, left, options = {})
        padding, height = 5, 20
        x2 = settings[:y] + height/2
        options.merge! size: 8, valign: :center, height: height
        options.merge! overflow: :shrink_to_fit, disable_wrap_by_char: true
        text_box label, options.merge(at: [left, x2])
      end
    end
  end
end
