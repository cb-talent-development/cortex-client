module Cortex
  class Posts  < Cortex::Resource
    def query(params = {})
      client.get('/posts', params)
    end

    def feed(params = {})
      client.get('/posts/feed', params)
    end

    def get(id)
      client.get("/posts/#{id}")
    end

    def save(post)
      client.save('/posts', post)
    end

    def delete(id)
      client.delete("/posts/#{id}")
    end

    def filters
      client.get('/posts/filters')
    end

    def related(id, params = {})
      client.get("/posts/feed/#{id}/related", params)
    end

    def authors
      client.get('/posts/feed/authors')
    end
  end
end
