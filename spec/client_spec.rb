require 'spec_helper'

describe Cortex::Client do

  let(:access_token) { '123' }
  let(:base_url) { 'http://localhost:3000' }
  let(:client) do
    Cortex::Client.new(access_token, base_url)
  end

  it 'should preserve settings' do
    client.access_token.should == access_token
    client.base_url.should == base_url
  end
end
