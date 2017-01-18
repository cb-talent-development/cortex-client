require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'cortex/faraday_middleware/response_failures'
require 'cortex/faraday_middleware/normalize_uri_path'

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
        ## Request middleware first:
        conn.use Cortex::FaradayMiddleware::NormalizeURIPath
        conn.request :oauth2, access_token.is_a?(OAuth2::AccessToken) ? access_token.token : access_token
        conn.request :json

        ## Response middleware second:
        conn.response :mashify
        conn.use Cortex::FaradayMiddleware::ResponseFailures
        conn.response :json, :content_type => /\bjson$/

        ## Adapter always last:
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
