require 'cortex/connection'
require 'cortex/request'
require 'cortex/resource'
require 'cortex/posts'
require 'cortex/users'
require 'cortex/webpages'
require 'cortex/result'
require 'oauth2'
require 'cortex/exceptions'

module Cortex
  class Client
    attr_reader :posts, :users
    attr_accessor :access_token, :base_url, :auth_method
    @key = ''
    @secret = ''

    include Cortex::Connection
    include Cortex::Request

    def initialize(hasharg)
      @base_url = hasharg[:base_url] || 'https://cbcortex.com/api/v1/'
      if hasharg.has_key? :access_token
        @access_token = hasharg[:access_token]
      else
        @key = hasharg[:key]
        @secret = hasharg[:secret]
        @access_token = get_cc_token
      end
      @posts = Cortex::Posts.new(self)
      @users = Cortex::Users.new(self)
      @webpages = Cortex::Webpages.new(self)
    end

    def get_cc_token
      begin
        client = OAuth2::Client.new(@key, @secret, site: @base_url)
        client.client_credentials.get_token
      rescue Faraday::ConnectionFailed
        raise Cortex::Exceptions::ConnectionFailed.new(base_url: @base_url)
      end
    end
  end
end
