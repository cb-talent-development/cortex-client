Version History
====
    * All Version bumps are required to update this file as well!
----

* 0.10.0:
  * Utilize `Addressable::URI` as Faraday's default URI parser so that resourceful URI fragments are escaped and parsed properly
  * Utilize `Faraday::Middleware` for `Hashie::Mash`ing & OAuth2 Token insertion
  * Update dependencies
  * No major breaking changes anticipated, but please *test* your use cases!
* 0.9.0 - Add total pages, next page, and prev page to result object
* 0.8.0 - Revert ETag caching flow implementation
* 0.7.0 - Implement ability to specify OAuth scopes
* 0.6.1 - Update various dependencies
* 0.6.0 - Implement ETag-based caching flow for all endpoints
* 0.5.0 - Update OAuth2 gem to 1.0.0
