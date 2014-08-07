require 'spec_helper'

describe Cortex::Posts do

  let(:client) { Cortex::Client.new(access_token: '123') }

  describe :get do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/posts/1').and_return('response')
      client.posts.get(1).should == 'response'
    end
  end

  describe :feed do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/posts/feed', nil).and_return('response')
      client.posts.feed().should == 'response'
    end

    it 'should accept parameters and send them with the request' do
      client.should_receive(:get).with('/posts/feed', {q: "Test*"}).and_return('success')
      client.posts.feed(q: 'Test*').should == 'success'
    end
  end

  describe :save do
    context 'with an existing post' do
      it 'should correctly make the request' do
        post = {:id => 1, :title => 'Post'}
        client.should_receive(:put).with('/posts/1', post).and_return('response')
        client.posts.save(post).should == 'response'
      end
    end

    context 'with a new post' do
      it 'should correctly make the request' do
        post = {:title => 'Post'}
        client.should_receive(:post).with('/posts', post).and_return('response')
        client.posts.save(post).should == 'response'
      end
    end
  end

  describe :filters do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/posts/filters').and_return('success')
      client.posts.filters().should == 'success'
    end
  end

  describe :related do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/posts/feed/1/related', nil).and_return('success')
      client.posts.related(1).should == 'success'
    end
  end

  describe :authors do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/posts/feed/authors').and_return('success')
      client.posts.authors.should == 'success'
    end
  end
end
