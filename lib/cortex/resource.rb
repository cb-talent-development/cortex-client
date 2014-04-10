module Cortex
  class Resource
    def initialize(client)
      @client = client
    end

    protected
    attr_accessor :client
  end
end