require 'squid/settings'

module Squid
  # Abstract class that delegates unhandled calls to a +pdf+ object which
  # is convenient when working with Prawn methods
  class Base
    extend Settings

    attr_reader :pdf, :data

    def initialize(document, data = {}, settings = {})
      @pdf = document
      @data = data
      @settings = settings
    end

    # Delegates all unhandled calls to object returned by +pdf+ method.
    def method_missing(method, *args, &block)
      return super unless pdf.respond_to?(method)
      pdf.send method, *args, &block
    end
  end
end
