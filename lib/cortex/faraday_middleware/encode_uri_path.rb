require 'faraday/middleware'
require 'addressable/uri'

module Cortex
  module FaradayMiddleware
    class EncodeURIPath < Faraday::Middleware
      def call(env)
        env[:url].path = Addressable::URI.encode(env[:url].path)

        @app.call env
      end
    end
  end
end
