module Cortex
  class Client
    module Resources
      class Users < ResourceBase
        def get(id)
          v1.get(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'users', id: id})
        end

        def me
          v1.get(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'users', id: 'me'})
        end

        def create(body)
          v1.post(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'users', id: nil}, body)
        end

        def save(id, body)
          v1.put(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'users', id: id}, body)
        end

        def delete(id)
          v1.delete(APIs::V1::Endpoints::SINGLE_ITEM % {type: 'users', id: id})
        end

        def author(id, body)
          v1.put(APIs::V1::Endpoints::USER_AUTHOR % {id: id}, body)
        end
      end
    end
  end
end