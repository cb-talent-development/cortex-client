require_relative '../../../../spec_helper'

describe Cortex::Client::Resources::Posts do
  let(:id) { 1 }
  let(:body) { 'body' }
  let(:criteria) { 'criteria' }

  describe :feed do
    it 'makes a GET request to the /posts/feed endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/feed', nil) { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.feed).to eq(body)
    end

    it 'passes criteria' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/feed', 'criteria') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.feed(criteria)).to eq(body)
    end
  end

  describe :index do
    it 'makes a GET request to the /posts/feed endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/', nil) { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.index).to eq(body)
    end

    it 'passes criteria' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/', 'criteria') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.index(criteria)).to eq(body)
    end
  end

  describe :get do
    it 'makes a GET request to the /posts/1 endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/1') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.get(1)).to eq(body)
    end
  end

  describe :get_published do
    it 'makes a GET request to the /posts/feed/1 endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/feed/1') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.get_published(1)).to eq(body)
    end
  end

  describe :get_published do
    it 'makes a GET request to the /posts/feed/1/related endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/feed/1/related', nil) { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.related(1)).to eq(body)
    end

    it 'passes criteria' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/feed/1/related', 'criteria') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.related(id, criteria)).to eq(body)
    end
  end

  describe :filters do
    it 'makes a GET request to the /posts/filters endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/filters') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.filters).to eq(body)
    end
  end

  describe :authors do
    it 'makes a GET request to the /posts/authors endpoint' do
      api = double
      expect(api).to receive(:get).with('/api/v1/posts/authors') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.authors).to eq(body)
    end
  end

  describe :create do
    it 'makes a POST request to the /posts/ endpoint with a body' do
      api = double
      expect(api).to receive(:post).with('/api/v1/posts/', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.create(body)).to eq(body)
    end
  end

  describe :save do
    it 'makes a PUT request to the /posts/id endpoint with a body' do
      api = double
      expect(api).to receive(:put).with('/api/v1/posts/1', 'body') { body }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.save(id, body)).to eq(body)
    end
  end

  describe :delete do
    it 'makes a DELETE request to the /posts/id endpoint' do
      api = double
      expect(api).to receive(:delete).with('/api/v1/posts/1') { 'ok' }
      apis = { v1: api }

      client = Cortex::Client::Resources::Posts.new(apis, {})
      expect(client.delete(id)).to eq('ok')
    end
  end
end