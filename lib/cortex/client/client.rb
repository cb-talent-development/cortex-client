require 'oauth2'
require 'cortex/client/apis/api_base'
require 'cortex/client/apis/v1'
require 'cortex/client/config'
require 'cortex/client/response'
require 'cortex/client/resources/resource_base'
require 'cortex/client/resources/posts'

module Cortex
  module Client
    class Client
      attr_reader :posts

      def initialize
        @posts = Resources::Posts.new(apis, nil)
      end

      private

      def apis
        { v1: APIs::V1.new }
      end
    end
  end
end