module Cortex
  class Webpages < Cortex::Resource
    def get_feed(id)
      client.get("/webpages/feed", {:url => id})
    end
  end
end
