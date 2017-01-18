require 'faraday/middleware'
require 'addressable/uri'

module Cortex
  module FaradayMiddleware
    class NormalizeURIPath < Faraday::Middleware
      def call(env)
        env[:url].path = Addressable::URI.normalize_component(env[:url].path)

        @app.call env
      end
    end
  end
end
