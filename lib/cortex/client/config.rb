module Cortex
  module Client
    class Config
      attr_accessor :client_id, :client_secret, :api_base, :adapter, :oauth_adapter

      def initialize
        @api_host = ENV['CORTEX_API_HOST'] || "https://api.cbcortex.com/api"
      end
    end

    def self.configure
      @config ||= Config.new
      yield(@config) if block_given?
      @config
    end

    def self.config
      @config || configure
    end
  end
end