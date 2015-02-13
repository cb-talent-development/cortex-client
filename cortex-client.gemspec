# encoding: utf-8
require './lib/cortex/client/version'

Gem::Specification.new do |s|
  s.name          = 'cortex-client'
  s.version       = Cortex::Client::VERSION
  s.summary       = 'Cortex API Client'
  s.homepage      = 'https://github.com/cb-talent-development/cortex-client'
  s.authors       = ['Bennett Goble']
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/).reject { |f| f == '.gitignore' }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'mocha'

  s.add_dependency 'faraday', '~> 0.9.0'
  s.add_dependency 'faraday_middleware', '~> 0.9.0'
  s.add_dependency 'oauth2', '~>0.9.0'
end
