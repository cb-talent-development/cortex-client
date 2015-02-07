require 'faraday'
require 'faraday_middleware'

module Cortex
  module Client
    module APIs
      class APIBase
        def initialize(options)
          @options = options
        end

        protected

        attr_accessor :options

        def connection(connection_options = {})
          conn_options = default_connection_options.merge(connection_options)
          Faraday.new(options[:api_host], conn_options) do |conn|
            conn.adapter faraday_client
            conn.request :oauth2, access_token.token
            conn.request :json
            conn.response :json, :content_type => /\bjson$/
          end
        end

        def faraday_client
          options[:client] || Faraday.default_adapter
        end

        def default_connection_options
          {
            headers: {
              user_agent: "cortex-client (Ruby) - #{Cortex::Client::VERSION}"
            },
            url: options[:api_host]
          }
        end

        def build_response(response)
          status  = response.status
          headers = response.headers
          body    = response.body
          Cortex::Client::Response.new(status: status, headers: headers, body: body)
        end
      end
    end
  end
end