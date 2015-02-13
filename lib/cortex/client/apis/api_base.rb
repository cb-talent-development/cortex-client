require 'faraday'
require 'faraday_middleware'

module Cortex
  module Client
    module APIs
      class APIBase
        def initialize(options = {})
          @options = options
        end

        protected

        attr_accessor :options

        def connection(connection_options = {})
          conn_options = default_connection_options.merge(connection_options)
          Faraday.new(Cortex::Client.config.api_base, conn_options) do |conn|
            conn.adapter faraday_client
            conn.request :oauth2, access_token.token
            conn.request :json
            conn.response :json, :content_type => /\bjson$/
          end
        end

        def access_token
          @access_token ||= begin
            oauth_options = @options[:oauth_options] || {}
            client = oauth_client.new(oauth_options)
            client.token
          end
        end

        def oauth_client
          Cortex::Client.config.oauth_adapter || Cortex::Client::OAuth
        end

        def faraday_client
          Cortex::Client.config.adapter || Faraday.default_adapter
        end

        def default_connection_options
          {
            headers: {
              user_agent: "cortex-client (Ruby) - #{Cortex::Client::VERSION}",
              authorization: "Bearer #{access_token.token}"
            },
            url: Cortex::Client.config.api_base
          }
        end

        def build_response(response)
          status  = response.status
          headers = response.headers
          body    = response.body
          Cortex::Client::Response.new(status, headers, body)
        end
      end
    end
  end
end