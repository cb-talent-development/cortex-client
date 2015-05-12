module Cortex
  class Client
    module Resources
      class Posts < ResourceBase
        def feed(criteria=nil)
          v1.get(APIs::V1::Endpoints::POST_FEED, criteria)
        end

        def index(criteria=nil)
          v1.get(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'posts', id: nil}, criteria)
        end

        def get(id)
          v1.get(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'posts', id: id})
        end

        def get_published(id)
          v1.get(APIs::V1::Endpoints::PUBLISHED % {id: id})
        end

        def related(id, criteria=nil)
          v1.get(APIs::V1::Endpoints::RELATED % {id: id}, criteria)
        end

        def filters
          v1.get(APIs::V1::Endpoints::FILTERS)
        end

        def authors
          v1.get(APIs::V1::Endpoints::AUTHORS)
        end

        def create(body)
          v1.post(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'posts', id: nil}, body)
        end

        def save(id, body)
          v1.put(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'posts', id: id}, body)
        end

        def delete(id)
          v1.delete(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'posts', id: id})
        end
      end
    end
  end
end