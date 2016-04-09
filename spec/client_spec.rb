require 'spec_helper'

RSpec.describe Cortex::Client do

  let(:access_token) { '123' }
  let(:base_url) { 'http://localhost:3000' }
  let(:scopes) { 'view:posts view:media' }
  let(:client) do
    Cortex::Client.new(access_token: access_token, base_url: base_url, scopes: scopes)
  end

  it 'should preserve settings' do
    expect(client.access_token).to eq(access_token)
    expect(client.base_url).to eq(base_url)
  end
end
