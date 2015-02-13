require 'faraday'
require 'faraday_middleware'

module Cortex
  class Client
    module APIs
      class APIBase
        attr_accessor :client
        def initialize(options = {})
          @options = options
          connection_options = @options[:connection_options] || {}
        end

        protected

        attr_accessor :options

        def connection(connection_options = {})
          conn_options = default_connection_options.merge(connection_options)
          Faraday.new(Cortex::Client.config.api_base, conn_options) do |conn|
            conn.request :oauth2, access_token.token
            conn.request :multipart # To upload files
            conn.request :json
            conn.response :json, :content_type => /\bjson$/
            conn.adapter faraday_client
          end
        end

        def access_token
          @access_token ||= begin
            oauth_client.token
          end
        end

        def oauth_client
          @client ||= begin
            oauth_options = @options[:oauth_options] || {}
            client = Cortex::Client.config.oauth_adapter || Cortex::Client::OAuth
            @client = client.new(oauth_options)
          end
          
        end

        def faraday_client
          Cortex::Client.config.faraday_adapter || Faraday.default_adapter
        end

        def default_connection_options
          {
            headers: {
              user_agent: "cortex-client (Ruby) - #{Cortex::Client::VERSION}"
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