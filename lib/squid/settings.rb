require 'squid/config'

module Squid
  # @private
  module Settings
    # For each key, create an attribute reader with a settings value.
    # First, check if an option with the key exists.
    # For example: {formats: [:currency]} ->> [:currency]
    # Then, check is an option with the singular version of the key exists.
    # For example: {format: :currency} ->> [:currency]
    # Finally, check whether the key has a value in Squid configuration.
    # For example: config.formats = [:currency] ->> [:currency]
    def has_settings(*keys)
      keys.each do |key|
        define_method(key) do
          singular_key = key.to_s.singularize.to_sym
          if @settings.key? key
            @settings[key]
          elsif @settings.key? singular_key
            [@settings[singular_key]]
          else
            Squid.configuration.public_send key
          end
        end
      end
    end
  end
end
