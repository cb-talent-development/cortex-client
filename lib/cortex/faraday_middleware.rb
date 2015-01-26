require 'faraday'
require 'faraday_middleware'

module Cortex
  class FaradayMiddleware < Faraday::Middleware
    def call(env)
      begin
        @app.call(env)
      rescue Faraday::ConnectionFailed
        raise Cortex::Exceptions::ConnectionFailed(base_url: env[:url])
      end
    end
  end
end
