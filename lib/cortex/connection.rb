require 'faraday'
require 'faraday_middleware'
require 'addressable/uri'

require 'cortex/faraday_middleware/response_failures'

module Cortex
  module Connection
    def connection
      options = {
        :headers => {
            :user_agent => "cortex-client-ruby - #{Cortex::VERSION}"
        },
        :url => base_url
      }

      if access_token.is_a?(OAuth2::AccessToken) && access_token.expired?
        @access_token = get_cc_token
      end

      Faraday::Utils.default_uri_parser = Addressable::URI
      Faraday.new options do |conn|
        # Hello, temporal coupling. Order matters here.

        ## Request middleware first:
        conn.use ::FaradayMiddleware::OAuth2, access_token.is_a?(OAuth2::AccessToken) ? access_token.token : access_token

        ## Response middleware second:
        conn.use ::FaradayMiddleware::Mashify
        conn.use Cortex::FaradayMiddleware::ResponseFailures

        conn.request :json
        conn.response :json, :content_type => /\bjson$/

        ## Adapter always last:
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
