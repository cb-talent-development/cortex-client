module Cortex
  class Posts  < Cortex::Resource
    def query
      client.get('/posts')
    end

    def feed
      client.get('/posts/feed')
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
  end
end
