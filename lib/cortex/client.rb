require 'oauth2'

require 'cortex/connection'
require 'cortex/request'
require 'cortex/resource'
require 'cortex/content_items'
require 'cortex/posts'
require 'cortex/users'
require 'cortex/webpages'
require 'cortex/result'

module Cortex
  class Client
    attr_reader :posts, :users, :webpages, :content_items
    attr_accessor :access_token, :base_url, :auth_method
    @key = ''
    @secret = ''
    @scopes = ''

    include Cortex::Connection
    include Cortex::Request

    def initialize(hasharg)
      @base_url = hasharg[:base_url] || 'http://cortex.dev/api/v1'
      if hasharg.has_key? :access_token
        @access_token = hasharg[:access_token]
      else
        @key = hasharg[:key]
        @secret = hasharg[:secret]
        @scopes ||= hasharg[:scopes]
        @access_token = get_cc_token
      end
      @posts = Cortex::Posts.new(self)
      @users = Cortex::Users.new(self)
      @webpages = Cortex::Webpages.new(self)
      @content_items = Cortex::ContentItems.new(self)
    end

    def get_cc_token
      begin
        client = OAuth2::Client.new(@key, @secret, site: @base_url)
        client.client_credentials.get_token({scope: @scopes})
      rescue Faraday::ConnectionFailed
        raise Cortex::Exceptions::ConnectionFailed.new(base_url: @base_url)
      end
    end
  end
end
