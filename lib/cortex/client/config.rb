module Cortex
  module Client
    module Config
      VALID_OPTION_KEYS = [
        :client_id,
        :client_secret,
        :api_host
      ]

      attr_accessor *VALID_OPTIONS_KEYS

      def configure
        yield self
        self
      end

      def options
        options = {}
        VALID_OPTIONS_KEYS.each { |name| options[name] = send(name) }
        options
      end

      def api_host
        ENV['CORTEX_API_HOST'] || @api_host || 'https://api.cbcortex.com'
      end

      def debug
        ENV['CORTEX_DEBUG'] || @debug || false
      end
    end
  end
end