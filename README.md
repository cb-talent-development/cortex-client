# cortex-client

[![Build Status](https://magnum.travis-ci.com/cbdr/cortex-client.svg?token=xfxzhqp5b1sdboEHmYQm)](https://magnum.travis-ci.com/cbdr/cortex-client)
[![Gem Version](https://badge.fury.io/rb/cortex-client.svg)](http://badge.fury.io/rb/cortex-client)

Ruby client library for [cortex](https://github.com/cb-talent-development/cortex)'s API.

**There has been a massive refactoring, and the interface has changed. PLEASE read before using.**

## Constructor

The constructor has been reworked due to the addition of configuration.

```ruby
require 'cortex-client'

client = Cortex::Client.new

client.posts.feed().each do |post|
  puts post
end
```

It will also accept options.

```ruby
require 'cortex-client'

client = Cortex::Client.new({
  faraday_adapter: <Alternate Faraday Adapter>, # Defaults to :net_http
  oauth_options: { # Provides options specific to OAuth
    client_id: '<Cortex API ID>',
    client_secret: '<Cortex API Secret>',
    api_base: '<Cortex Base Url>', # Defaults to 'https://api.cbcortex.com'
    oauth_adapter: <Alternate OAuth Adapter>, # Defaults to Cortex::Client::OAuth
    token_type: :token_type, # Defaults to :client_credentials
    redirect_uri: 'redirect uri' # Required for :authorizaton_code tokens. No Default
    authorization_code: 'authorization code', # Eventually required for authorization_code tokens. No Default
    authorize_url: 'authorize url', # Defaults to '/oauth/authorize'
    token_url: 'token url' #defaults to '/oauth/token'
  },
  connection_options: {} # Any options are passed to Faraday
})
```

This allows you to make Authorization Code requests (request on behalf of a Cortex user).

## Configration

Provides gem-wide settings. Any of these can be overridden be the constructor.

```ruby
Cortex::Client.configure do |config|
  config.client_id = '<CORTEX API ID>' # Required
  config.client_secret = '<CORTEX API SECRET>' # Required
  config.api_base = '<CORTEX BASE URL>' # Defaults to 'https://api.cbcortex.com'
  config.faraday_adapter = <Alternate Faraday adapter> # Defaults to :net_http
  config.oauth_adapter = <Alternate OAuth adapter> # Defaults to Cortex::Client::OAuth
end

```

## Result object

Cortex::Client will return a Cortex::Client::Result object.

The following methods are available:

- body
- errors
- page
- per_page
- total
- status
- body
- headers

### Supported Endpoints

- *Users* - me, get, save, create, delete, author
- *Posts* - feed, index, get, get_published, related, filters, authors, create, save, delete
- *Media* - index, get, create, save, delete

### TODO
- Build result objects up
- Handle Pagination
