module Cortex
  class Client
    class Config
      attr_accessor :client_id, :client_secret, :api_base, :faraday_adapter, :oauth_adapter

      def initialize
        @api_base = ENV['CORTEX_API_HOST'] || "https://api.cbcortex.com/"
        @faraday_adapter = ENV['FARADAY_ADAPTER'] || :net_http
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