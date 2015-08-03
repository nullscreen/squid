require 'squid/configuration'

module Squid
  # Provides methods to read and write global configuration settings.
  #
  # A typical usage is to set the default dimensions and colors for charts.
  #
  # @example Set the default height for Squid graphs:
  #   Squid.configure do |config|
  #     config.height = 150
  #   end
  #
  # Note that Squid.configure has precedence over values through with
  # environment variables (see {Squid::Configuration}).
  #
  module Config
    # Yields the global configuration to the given block.
    #
    # @example
    #   Squid.configure do |config|
    #     config.height = 150
    #   end
    #
    # @yield [Squid::Configuration] The global configuration.
    def configure
      yield configuration if block_given?
    end

    # Returns the global {Squid::Configuration} object.
    #
    # While this method _can_ be used to read and write configuration settings,
    # it is easier to use {Squid::Config#configure} Squid.configure}.
    #
    # @example
    #     Squid.configuration.height = 150
    #
    # @return [Squid::Configuration] The global configuration.
    def configuration
      @configuration ||= Squid::Configuration.new
    end
  end

  # @note Config is the only module auto-loaded in the Squid module,
  #       in order to have a syntax as easy as Squid.configure
  extend Config
end
