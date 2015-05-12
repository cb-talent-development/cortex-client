require 'ostruct'
require_relative '../lib/cortex-client'

RSpec.configure do |config|
  config.mock_framework = :rspec
end

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end

  failure_message do |owner|
    "expected that #{owner} would have a constant #{const} defined"
  end

  failure_message_when_negated do |owner|
    "expected that #{owner} would not have a constant #{const} defined"
  end

  description do
    "have constant #{const} defined"
  end
end