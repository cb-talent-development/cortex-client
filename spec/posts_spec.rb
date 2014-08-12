require 'spec_helper'

describe Cortex::Posts do

  let(:client) { Cortex::Client.new(access_token: '123') }

  describe :get do
    it 'should correctly make the request' do
      expect(client).to receive(:get).with('/posts/1').and_return('response')
      expect(client.posts.get(1)).to eq('response')
    end
  end

  describe :feed do
    it 'should correctly make the request' do
      expect(client).to receive(:get).with('/posts/feed', nil).and_return('response')
      expect(client.posts.feed()).to eq('response')
    end

    it 'should accept parameters and send them with the request' do
      expect(client).to receive(:get).with('/posts/feed', {q: "Test*"}).and_return('success')
      expect(client.posts.feed(q: 'Test*')).to eq('success')
    end
  end

  describe :save do
    context 'with an existing post' do
      it 'should correctly make the request' do
        post = {:id => 1, :title => 'Post'}
        expect(client).to receive(:put).with('/posts/1', post).and_return('response')
        expect(client.posts.save(post)).to eq('response')
      end
    end

    context 'with a new post' do
      it 'should correctly make the request' do
        post = {:title => 'Post'}
        expect(client).to receive(:post).with('/posts', post).and_return('response')
        expect(client.posts.save(post)).to eq('response')
      end
    end
  end

  describe :filters do
    it 'should correctly make the request' do
      expect(client).to receive(:get).with('/posts/filters').and_return('success')
      expect(client.posts.filters()).to eq('success')
    end
  end

  describe :related do
    it 'should correctly make the request' do
      expect(client).to receive(:get).with('/posts/feed/1/related', nil).and_return('success')
      expect(client.posts.related(1)).to eq('success')
    end
  end

  describe :authors do
    it 'should correctly make the request' do
      expect(client).to receive(:get).with('/posts/feed/authors').and_return('success')
      expect(client.posts.authors).to eq('success')
    end
  end
end
