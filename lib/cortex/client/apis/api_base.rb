require 'faraday'
require 'faraday_middleware'

module Cortex
  module Client
    module APIs
      class APIBase
        def initialize(options = nil)
          @options = options
        end

        protected

        attr_accessor :options

        def connection(connection_options = {})
          conn_options = default_connection_options.merge(connection_options)
          Faraday.new(Cortex::Client.config.api_host, conn_options) do |conn|
            conn.adapter faraday_client
            conn.request :oauth2, access_token.token
            conn.request :json
            conn.response :json, :content_type => /\bjson$/
          end
        end

        def access_token
          @access_token ||= begin
            client = ::OAuth2::Client.new(Cortex::Client.config.client_id, 
                                          Cortex::Client.config.client_secret, 
                                          site: Cortex::Client.config.api_host)
            client.client_credentials.get_token
          end
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
            proxy: {
              uri: 'http://localhost:8888/'
            },
            url: Cortex::Client.config.api_host
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