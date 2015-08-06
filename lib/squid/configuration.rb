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
  #     config.gridlines = 4
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
    # @return [Integer] the default graph height
    attr_accessor :baseline, :border, :chart, :format, :gridlines, :height
    attr_accessor :legend, :ticks

    # Initialize the global configuration settings, using the values of
    # the specified following environment variables by default.
    def initialize
      @baseline  = ENV.fetch('SQUID_BASELINE', 'true').in? true_values
      @border    = ENV.fetch('SQUID_BASELINE', 'false').in? true_values
      @chart     = ENV.fetch('SQUID_CHART', 'true').in? true_values
      @format    = ENV.fetch('SQUID_FORMAT', nil)
      @legend    = ENV.fetch('SQUID_LEGEND', 'true').in? true_values
      @gridlines = ENV.fetch('SQUID_GRIDLINES', '4').to_i
      @height    = ENV.fetch('SQUID_HEIGHT', '200').to_f
      @ticks     = ENV.fetch('SQUID_TICKS', 'true').in? true_values
    end

  private

    def true_values
      %w(1 t T true TRUE)
    end
  end
end
