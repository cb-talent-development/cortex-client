module Cortex
  class Webpages < Cortex::Resource
    def get_feed(id)
      client.get("/webpages/feed/#{id}")
    end
  end
end
