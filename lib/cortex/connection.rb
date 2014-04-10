require 'faraday'
require 'faraday_middleware'

module Cortex
  module Connection
    def connection
      options = {
        :headers => {
          :user_agent => "cortex-client (Ruby) - #{Cortex::VERSION}"
        },
        :url => base_url
      }
      Faraday.new options do |conn|
        conn.request :oauth2, access_token
        conn.request :json
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
