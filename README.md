# cortex-client

[![Build Status](https://travis-ci.org/cb-talent-development/cortex-client.svg)](https://travis-ci.org/cb-talent-development/cortex-client)
[![Gem Version](https://badge.fury.io/rb/cortex-client.svg)](http://badge.fury.io/rb/cortex-client)

Ruby client library for [cortex](https://github.com/cb-talent-development/cortex)'s API.

**0.1 Changes the constructor**

Please note that 0.1.0 and onward now require a hash be passed. You can access the previous functionality with the access_token key:

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

### Supported Endpoints

- *Users* - me, get ,save
- *Posts* - query, get, save, delete, feed

### TODO
- Handle pagination
- Support for search queries
- /media
