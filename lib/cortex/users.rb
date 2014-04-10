module Cortex
  class Users < Cortex::Resource
    def me
      client.get('/users/me')
    end

    def get(id)
      client.get("/users/#{id}")
    end

    def save(user)
      client.save('/users', user)
    end
  end
end
