module Cortex
  class Posts  < Cortex::Resource
    def query
      client.get('/posts')
    end

    def feed(params = nil)
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

    def related(id)
      client.get("/posts/feed/#{id}/related")
    end

    def authors
      client.get("/posts/feed/authors")
    end
  end
end
