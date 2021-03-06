# encoding: utf-8
require './lib/cortex/version'

Gem::Specification.new do |s|
  s.name          = 'cortex-client'
  s.version       = Cortex::VERSION
  s.summary       = 'Cortex API Client'
  s.homepage      = 'https://github.com/cortex-cms/cortex-client-ruby'
  s.authors       = ['CareerBuilder Employer Site & Content Products']
  s.email         = ['EmployerSiteContentProducts@cb.com']
  s.license       = 'Apache-2.0'

  s.files         = `git ls-files`.split($/).reject { |f| f == '.gitignore' }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'mocha', '~> 1.2'
  s.add_development_dependency 'webmock', '~> 2.3'

  s.add_dependency 'oauth2', '~> 1.4'
  s.add_dependency 'faraday', '~> 0.12'
  s.add_dependency 'faraday_middleware', '~> 0.11'
  s.add_dependency 'addressable', '~> 2.5'
  s.add_dependency 'hashie', '~> 3.5'
  s.add_dependency 'cortex-exceptions', '~> 0.0.4'
end
