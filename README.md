# cortex-client

[![Build Status](https://travis-ci.org/cb-talent-development/cortex-client.svg)](https://travis-ci.org/cb-talent-development/cortex-client)
[![Gem Version](https://badge.fury.io/rb/cortex-client.svg)](http://badge.fury.io/rb/cortex-client)

Ruby client library for [cortex](https://github.com/cb-talent-development/cortex)'s API.

## Constructor

```ruby
require 'cortex-client'

client = Cortex::Client.new(access_token: 'access_token')

client.posts.query().each do |post|
  puts post
end
```

Alternatively, cortex-client will handle OAuth2 authentication for you:

```ruby
require 'cortex-client'

client = Cortex::Client.new(key: 'my-app-id', secret: 'secrey-key-ssh', base_url: 'base_url')
 
 client.posts.query().each do |post|
  puts post
 end
```

## Result object

Cortex::Client will return a Cortex::Result object. The following methods are available:

- contents
- is_error?
- errors
- page
- per_page
- total_items
- range
- range_start
- range_end
- raw_headers

### Supported Endpoints

- *Users* - me, get, save
- *Posts* - query, get, save, delete, feed, feed/get, feed/get/released, feed/authors

### TODO
- Handle pagination
- /media
