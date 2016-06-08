require 'squid/format'

module Squid
  class Point
    extend Format

    def self.for(series, minmax:, height:, labels:, stack:, formats:, precision:)
      @min = Hash.new 0
      @max = Hash.new 0
      min, max = minmax
      offset = -> (value) { value * height.to_f / (max-min) }
      series.map.with_index do |values, series_i|
        values.map.with_index do |value, i|
          next if value.nil?
          h = y_for value, index: i, stack: false, &offset if value
          y = y_for value, index: i, stack: stack, &offset if value
          y = y - offset.call([min, 0].min) if value
          label = format_for value, formats[series_i], precision if labels[series_i]
          new y: y, height: h, index: i, label: label, negative: value.to_f < 0
        end.compact
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
