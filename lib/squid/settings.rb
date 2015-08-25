require 'squid/config'

module Squid
  # @private
  module Settings
    def has_settings(*keys)
      keys.each do |key|
        define_method key do
          @settings.fetch key, Squid.configuration.public_send(key)
        end
        private key
      end
    end
  end
end
