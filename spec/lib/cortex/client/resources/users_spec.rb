require_relative '../../../../spec_helper'

describe Cortex::Client::Resources::Users do
  let(:id) { 1 }
  let(:body) { 'body' }

  describe :get do
    it 'makes a GET request to the /users/1 endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/users/1') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.get(1)).to eq(body)
    end
  end

  describe :me do
    it 'makes a GET request to the /users/me endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/users/me') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.me).to eq(body)
    end
  end

  describe :create do
    it 'makes a POST request to the /users/ endpoint with a body' do
      api = double
      expect(api).to receive(:post).with('/api/v1/users/', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.create(body)).to eq(body)
    end
  end

  describe :save do
    it 'makes a PUT request to the /users/id endpoint with a body' do
      api = double
      expect(api).to receive(:put).with('/api/v1/users/1', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.save(id, body)).to eq(body)
    end
  end

  describe :delete do
    it 'makes a DELETE request to the /users/id endpoint' do
      api = double
      expect(api).to receive(:delete).with('/api/v1/users/1') { 'ok' }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.delete(id)).to eq('ok')
    end
  end

  describe :author do
    it 'makes a PUT request to the /api/v1/users/1/author endpoint with a body' do
      api = double
      expect(api).to receive(:put).with('/api/v1/users/1/author', body) { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Users.new(apis, {})
      expect(client.author(id, body)).to eq(body)
    end
  end
end