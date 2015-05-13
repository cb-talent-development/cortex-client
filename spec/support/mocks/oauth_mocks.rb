module Cortex
  class Client
    module Mocks
      class OAuth
        def initialize(options); end
        def token
          Token.new()
        end
      end
    end
  end
end

module Cortex
  class Client
    module Mocks
      class Token
        def token
          "token"
        end
      end
    end
  end
end
