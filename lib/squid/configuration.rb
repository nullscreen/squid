require 'ostruct'

module Squid
  # Provides an object to store global configuration settings.
  #
  # This class is typically not used directly, but by calling
  # {Squid::Config#configure Squid.configure}, which creates and updates a
  # single instance of {Squid::Configuration}.
  #
  # @example Set the default height for Squid graphs:
  #   Squid.configure do |config|
  #     config.height = 150
  #     config.steps = 4
  #   end
  #
  # @see Squid::Config for more examples.
  #
  # An alternative way to set global configuration settings is by storing
  # them in the following environment variables:
  #
  # * +SQUID_HEIGHT+ to store the default graph height
  #
  # In case both methods are used together,
  # {Squid::Config#configure Squid.configure} takes precedence.
  #
  # @example Set the default graph height:
  #   ENV['SQUID_HEIGHT'] =  '150'
  #   ENV['SQUID_GRIDLINES'] =  '4'
  #
  class Configuration < OpenStruct
    COLORS = '2e578c 5d9648 e7a13d bc2d30 6f3d79 7d807f'

    def self.boolean
      -> (value) { %w(1 t T true TRUE).include? value }
    end
    
    def self.integer
      -> (value) { value.to_i }
    end

    def self.symbol
      -> (value) { value.to_sym }
    end

    def self.float
      -> (value) { value.to_f }
    end
    
    def self.array
      -> (value) { value.split }
    end

    ATTRIBUTES = {
      baseline:     {default: 'true',      as: boolean},
      border:       {default: 'false',     as: boolean},
      chart:        {default: 'true',      as: boolean},
      colors:       {default: COLORS,      as: array},
      every:        {default: '1',         as: integer},
      format:       {default: 'integer',   as: symbol},
      height:       {default: '250',       as: float},
      labels:       {default: 'false',     as: boolean},
      legend:       {default: 'true',      as: boolean},
      line_widths:  {default: '3',         as: integer},
      steps:        {default: '4',         as: integer},
      ticks:        {default: 'true',      as: boolean},
      type:         {default: 'column',    as: symbol},
    }

    attr_accessor *ATTRIBUTES.keys

    # Initialize the global configuration settings.
    def initialize
      ATTRIBUTES.each do |key, options|
        var = "squid_#{key}".upcase
        value = ENV.fetch var, options[:default]
        public_send "#{key}=", options[:as].call(value)
      end
    end
  end
end
