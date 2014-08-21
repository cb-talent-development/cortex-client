require 'spec_helper'

describe Cortex::Users do

  let(:client) { Cortex::Client.new(access_token: '123') }

  describe :me do
    it 'should correctly make the request' do
      client.expects(:get).with('/users/me').returns('response')
      response = client.users.me
      expect(response).to eq('response')
    end
  end

  describe :get do
    it 'should correctly make the request' do
      client.expects(:get).with('/users/1').returns('response')
      expect(client.users.get(1)).to eq('response')
    end
  end

  describe :save do
    context 'with an existing user' do
      it 'should correctly make the request' do
        user = {:id => 1, :email => 'user@cbcortex.com'}
        client.expects(:put).with('/users/1', user).returns('response')
        response = client.users.save(user)
        expect(response).to eq('response')
      end
    end

    context 'with a new user' do
      it 'should correctly make the request' do
        user = {:email => 'user@cbcortex.com'}
        client.expects(:post).with('/users', user).returns('response')
        response = client.users.save(user)
        expect(response).to eq('response')
      end
    end
  end
end
