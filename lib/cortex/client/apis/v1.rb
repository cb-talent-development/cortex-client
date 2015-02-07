module Cortex
  module Client
    module APIs
      class V1 < APIBase
        def get(path, query = {})
          response = connection.get(path, query)
          build_response(response)
        end

        module Endpoints
          POST_FEED = '/v1/posts/feed'
        end
      end
    end
  end
end