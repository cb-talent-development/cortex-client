require 'oauth2'

module Cortex
  class Client
    class OAuth
      VALID_TYPES = %i[authorization_code client_credentials].freeze # Why is %i array of symbols? Why not %s or %y??
      attr_reader :client_id, :client_secret, :api_base, :authorize_url, :token_url, :token

      def initialize(opt = {})
        @authorize_url = opt[:authorize_url] || '/oauth/authorize'
        @token_url = opt[:token_url] || '/oauth/token'
        @client_id = opt[:client_id] || Cortex::Client.config.client_id
        @client_secret = opt[:client_secret] || Cortex::Client.config.client_secret
        @api_base = opt[:api_base] || Cortex::Client.config.api_base
        @token_type = opt[:token_type] || :client_credentials
        raise ArgumentError "Invalid token_type, valid options are: #{VALID_TYPES}" unless VALID_TYPES.include? @token_type
        if @token_type == :authorization_code
          @authorization_code = opt[:authorization_code]
          @redirect_uri = opt[:redirect_uri]
          self.class.class_eval { attr_accessor :authorization_code, :redirect_uri }
          raise ArgumentError "Must include redirect_uri when using authorization_code" unless @redirect_uri
        end
        @client = OAuth2::Client.new(@client_id, @client_secret, site: @api_base, authorize_url: @authorize_url, token_url: @token_url)
      end

      def authorize_url
        raise ArgumentError unless @token_type == :authorization_code || @redirect_uri.nil?
        @client.auth_code.authorize_url(redirect_uri: @redirect_uri)
      end

      def token
        case @token_type
        when :authorization_code
          raise ArgumentError if @authorization_code.nil? || @redirect_uri.nil?
          @token = @client.auth_code.get_token(@authorization_code, redirect_uri: @redirect_uri)
        when :client_credentials
          @token = @client.client_credentials.get_token
        end
      end
    end
  end
end