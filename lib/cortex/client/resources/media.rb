module Cortex
  class Client
    module Resources
      class Media < ResourceBase
        def index(criteria=nil)
          v1.get(APIs::V1::Endpoints::MEDIA % {id: nil}, criteria)
        end

        def get(id)
          v1.get(APIs::V1::Endpoints::MEDIA % {id: id})
        end

        def create(body)
          v1.post(APIs::V1::Endpoints::MEDIA, body)
        end

        def save(id, body)
          v1.put(APIs::V1::Endpoints::MEDIA % {id: id}, body)
        end

        def delete(id)
          v1.delete(APIs::V1::Endpoints::MEDIA % {id: id})
        end
      end
    end
  end
end