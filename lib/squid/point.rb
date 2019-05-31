require 'squid/format'

module Squid
  class Point
    extend Format

    def self.for(series, minmax:, height:, labels:, stack:, formats:, type:)
      @min = Hash.new 0
      @max = Hash.new 0
      min, max = minmax

      case type
        when :point
          adjusted_series = series.map{|array| array.map{ |n| (minmax[0]..minmax[1]).include?(n) ? n : nil } }
        when :line, :two_axis
          adjusted_series = series
        when :column
          adjusted_series = series.map do |array|
            array.map do |n|
              if (minmax[0]..minmax[1]).include?(n)
                n - minmax[0]
              elsif n > max
                max - min
              else
                nil
              end
            end
          end
        when :stack
          adjusted_series = series
      end

      offset = -> (value) { value * height.to_f / (max-min) }

      case type
        when :point
          offset = -> (value) { value * height.to_f / (max-min) }
        when :line, :two_axis
          offset = -> (value) { value * height.to_f / (max-min) }
        when :column
          offset = -> (value) { value * height.to_f / (max-min) }
        when :stack
          offset = -> (value) { value * height.to_f / (max-min) }
      end

      adjusted_series.map.with_index do |values, series_i|
        values.map.with_index do |value, i|
          h = y_for value, index: i, stack: false, &offset if value
          y = y_for value, index: i, stack: stack, &offset if value
          unless type == :column
            y = y - offset.call(min) if value
          end
          label = format_for value, formats[series_i] if labels[series_i]
          new y: y, height: h, index: i, label: label, negative: value.to_f < 0
        end
      end
    end

    attr_reader :y, :height, :index, :label, :negative

    def initialize(y:, height:, index:, label:, negative:)
      @y, @height, @index, @label, @negative = y, height, index, label, negative
    end

  private
    def self.y_for(value, index:, stack:, &block)
      if stack
        hash = (value > 0) ? @max : @min
        yield(hash[index] += value)
      else
        yield(value)
      end
    end
  end
end
