# encoding: utf-8
require './lib/cortex/version'

Gem::Specification.new do |s|
  s.name          = 'cortex-client'
  s.version       = Cortex::VERSION
  s.summary       = 'Cortex API Client'
  s.homepage      = 'https://github.com/cb-talent-development/cortex-client'
  s.authors       = ['Bennett Goble']
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/).reject { |f| f == '.gitignore' }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.add_dependency 'faraday', '~> 0.8.9'
  s.add_dependency 'faraday_middleware', '~> 0.9.0'
end
