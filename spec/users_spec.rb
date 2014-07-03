require 'spec_helper'

describe Cortex::Users do

  let(:client) { Cortex::Client.new(access_token: '123') }

  describe :me do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/users/me').and_return('response')
      response = client.users.me
      response.should == 'response'
    end
  end

  describe :get do
    it 'should correctly make the request' do
      client.should_receive(:get).with('/users/1').and_return('response')
      client.users.get(1).should == 'response'
    end
  end

  describe :save do
    context 'with an existing user' do
      it 'should correctly make the request' do
        user = {:id => 1, :email => 'user@cbcortex.com'}
        client.should_receive(:put).with('/users/1', user).and_return('response')
        response = client.users.save(user)
        response.should == 'response'
      end
    end

    context 'with a new user' do
      it 'should correctly make the request' do
        user = {:email => 'user@cbcortex.com'}
        client.should_receive(:post).with('/users', user).and_return('response')
        response = client.users.save(user)
        response.should == 'response'
      end
    end
  end
end
