require_relative '../../../../spec_helper'

describe Cortex::Client::Resources::Media do
  let(:id) { 1 }
  let(:body) { 'body' }
  let(:criteria) { 'criteria' }

  describe :index do
    it 'makes a GET request to the /media/index endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/media/', nil) { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.index).to eq(body)
    end

    it 'passes criteria' do
      api = double
      expect(api).to receive(:get).with('/api/v1/media/', 'criteria') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.index(criteria)).to eq(body)
    end
  end

  describe :get do
    it 'makes a GET request to the /media/1 endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/media/1') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.get(1)).to eq(body)
    end
  end

  describe :create do
    it 'makes a POST request to the /media/ endpoint with a body' do
      api = double
      expect(api).to receive(:post).with('/api/v1/media/', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.create(body)).to eq(body)
    end
  end

  describe :save do
    it 'makes a PUT request to the /media/id endpoint with a body' do
      api = double
      expect(api).to receive(:put).with('/api/v1/media/1', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.save(id, body)).to eq(body)
    end
  end

  describe :delete do
    it 'makes a DELETE request to the /media/id endpoint' do
      api = double
      expect(api).to receive(:delete).with('/api/v1/media/1') { 'ok' }
      apis = { v1: api }

      client = Cortex::Client::Resources::Media.new(apis, {})
      expect(client.delete(id)).to eq('ok')
    end
  end
end