module Cortex
  module Cortex
    module Resources
      class Posts < ResourceBase
        def feed(criteria)
          v1.get(APIs::V1::Endpoints::POST_FEED, criteria)
        end
      end
    end
  end
end