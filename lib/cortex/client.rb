require 'cortex/client/oauth'
require 'cortex/client/apis/api_base'
require 'cortex/client/apis/v1'
require 'cortex/client/config'
require 'cortex/client/response'
require 'cortex/client/resources/resource_base'
require 'cortex/client/resources/posts'
require 'cortex/client/resources/media'
require 'cortex/client/resources/users'

module Cortex
  class Client
    attr_reader :posts, :media, :users

    def initialize(options = {}, apis = default_apis)
      @options = options
      @posts = Resources::Posts.new(apis, options)
      @media = Resources::Media.new(apis, options)
      @users = Resources::Users.new(apis, options)
    end

    private

    def default_apis
      { v1: APIs::V1.new(@options) }
    end
  end
end