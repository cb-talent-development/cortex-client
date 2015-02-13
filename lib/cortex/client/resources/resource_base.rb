module Cortex
  module Client
    module Resources
      class ResourceBase
        def initialize(apis, options)
          @options = options
          apis.each{ |name, value| send("#{name}=", value)  }
        end

        def client
          v1.client
        end

        protected
        
        attr_accessor :v1
      end
    end
  end
end
