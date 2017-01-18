require 'webmock/rspec'

require_relative '../lib/cortex-client'

RSpec.configure do |config|
  config.mock_framework = :mocha
end
