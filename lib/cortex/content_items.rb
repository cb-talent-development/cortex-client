module Cortex
  class ContentItems  < Cortex::Resource
    def query(params = {})
      client.get('/content_items', params)
    end

    def feed(params = {})
      client.get('/content_items/feed', params)
    end

    def get(id)
      client.get("/content_items/#{id}")
    end

    def get_published(id)
      client.get("/content_items/feed/#{id}")
    end

    def save(content_item)
      client.save('/content_items', content_item)
    end

    def delete(id)
      client.delete("/content_items/#{id}")
    end
  end
end
