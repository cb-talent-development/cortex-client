require 'cortex/connection'
require 'cortex/request'
require 'cortex/resource'
require 'cortex/posts'
require 'cortex/users'

module Cortex
  class Client
    attr_reader :posts, :users
    attr_accessor :access_token, :base_url

    include Cortex::Connection
    include Cortex::Request

    def initialize(access_token, base_url = 'https://cbcortex.com/api/v1')
      @access_token = access_token
      @base_url = base_url
      @posts = Cortex::Posts.new(self)
      @users = Cortex::Users.new(self)
    end
  end
end
