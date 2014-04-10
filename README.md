# cortex-client
Ruby client library for [cortex](https://github.com/cb-talent-development/cortex)'s API.

cortex-client does not handle fetching or refreshing an OAuth access_token. For this use a library such as [OAuth](http://oauth.rubyforge.org/).

```ruby
require 'cortex-client'

client = Cortex::Client.new(access_token)

client.posts.query().each do |post|
  puts post
end
```

### Supported Endpoints

- *Users* - me, get ,save
- *Posts* - query, get, save, delete

### TODO
- Handle pagination
- Support for search queries
- /media
