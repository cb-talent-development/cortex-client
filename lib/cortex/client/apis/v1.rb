module Cortex
  class Client
    module APIs
      class V1 < APIBase
        def get(path, query = {})
          response = connection.get(path, query)
          build_response(response)
        end

        def post(path, body)
          response = connection.post do |req|
            req.path = path
            req.body = body
          end
          build_response(response)
        end

        def put(path, body)
          response = connection.put do |req|
            req.path = path
            req.body = body
          end
          build_response(response)
        end

        def delete(path)
          response = connection.delete(path)
          build_response(response)
        end

        module Endpoints
          POST_FEED = '/api/v1/posts/feed'
          POST      = '/api/v1/posts/%{id}'
          PUBLISHED = '/api/v1/posts/feed/%{id}'
          RELATED   = '/api/v1/posts/feed/%{id}/related'
          AUTHORS   = '/api/v1/posts/authors'
          FILTERS   = '/api/v1/posts/filters'
          MEDIA     = '/api/v1/media/%{id}'
          USER      = '/api/v1/users/%{id}'
          USER_AUTHOR = '/api/v1/users/%{id}/author'
        end
      end
    end
  end
end