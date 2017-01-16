require 'faraday'

require 'cortex/exceptions'

module Cortex
  module FaradayMiddleware
    class ResponseFailures < Faraday::Middleware
      def call(env)
        begin
          @app.call(env)
        rescue Faraday::ConnectionFailed
          raise Cortex::Exceptions::ConnectionFailed.new(base_url: env[:url])
        end
      end
    end
  end
end
