module Cortex
  module Client
    module Resources
      class Posts < ResourceBase
        def feed(criteria=nil)
          v1.get(APIs::V1::Endpoints::POST_FEED, criteria)
        end

        def get(id)
          v1.get(APIs::V1::Endpoints::POST % {id: id})
        end

        def get_published(id)
          v1.get(APIs::V1::Endpoints::PUBLISHED % {id: id})
        end

        def related(id, criteria=nil)
          v1.get(APIs::V1::Endpoints::RELATED % {id: id}, criteria)
        end

        def filters
          v1.get(APIs::V1::Endpoints::Filters)
        end

        def authors
          v1.get(APIs::V1::Endpoints::Authors)
        end

        def create(body)
          v1.post(APIs::V1::Endpoints::POST % {id: nil}, body)
        end

        def save(id, body)
          v1.put(APIs::V1::Endpoints::POST % {id: id}, body)
        end

        def delete(id)
          v1.delete(APIs::V1::Endpoints::POST % {id: id})
        end
      end
    end
  end
end