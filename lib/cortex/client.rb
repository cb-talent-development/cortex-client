require 'cortex/connection'
require 'cortex/request'
require 'cortex/resource'
require 'cortex/posts'
require 'cortex/users'
require 'cortex/webpages'
require 'cortex/result'

module Cortex
  class Client
    attr_reader :posts, :users, :webpages
    attr_accessor :access_token, :base_url, :auth_method
    @key = ''
    @secret = ''
    @scopes = ''

    include Cortex::Connection
    include Cortex::Request

    def initialize(hasharg)
      @base_url = hasharg[:base_url] || 'https://cbcortex.com/api/v1'
      if hasharg.has_key? :access_token
        @access_token = hasharg[:access_token]
      else
        @key = hasharg[:key]
        @secret = hasharg[:secret]
        @scopes ||= hasharg[:scopes]
      end
      @posts = Cortex::Posts.new(self)
      @users = Cortex::Users.new(self)
      @webpages = Cortex::Webpages.new(self)
    end
  end
end
