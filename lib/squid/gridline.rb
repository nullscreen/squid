module Squid
  class Gridline
    def self.for(count:, skip_baseline:, height:)
      return [] if count.zero?
      height.step(0, -height/count.to_f).map do |y|
        new y: y unless skip_baseline && y.zero?
      end.compact
    end

    attr_reader :y

    def initialize(y:)
      @y = y
    end
  end
end