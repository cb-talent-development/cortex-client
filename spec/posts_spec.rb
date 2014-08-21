require 'spec_helper'

RSpec.describe Cortex::Posts do

  let(:client) { Cortex::Client.new(access_token: '123') }

  describe :get do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/1').returns('response')
      expect(client.posts.get(1)).to eq('response')
    end
  end

  describe :get_published do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/feed/1').returns('response')
      expect(client.posts.get_published(1)).to eq('response')
    end
  end

  describe :feed do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/feed', {}).returns('response')
      expect(client.posts.feed()).to eq('response')
    end

    it 'should accept parameters and send them with the request' do
      client.expects(:get).with('/posts/feed', {q: "Test*"}).returns('response')
      expect(client.posts.feed(q: 'Test*')).to eq('response')
    end
  end

  describe :save do
    context 'with an existing post' do
      it 'should correctly make the request' do
        post = {:id => 1, :title => 'Post'}
        client.expects(:put).with('/posts/1', post).returns('response')
        expect(client.posts.save(post)).to eq('response')
      end
    end

    context 'with a new post' do
      it 'should correctly make the request' do
        post = {:title => 'Post'}
        client.expects(:post).with('/posts', post).returns('response')
        expect(client.posts.save(post)).to eq('response')
      end
    end
  end

  describe :filters do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/filters').returns('response')
      expect(client.posts.filters()).to eq('response')
    end
  end

  describe :related do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/feed/1/related', {}).returns('response')
      expect(client.posts.related(1)).to eq('response')
    end
  end

  describe :authors do
    it 'should correctly make the request' do
      client.expects(:get).with('/posts/feed/authors').returns('response')
      expect(client.posts.authors).to eq('response')
    end
  end
end
