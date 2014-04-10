require 'spec_helper'

describe Cortex::Request do
  let(:client) { Cortex::Client.new('123') }

  context 'with a cortex error response' do
    it 'should return the error object' do
      body = {'error' => 'Validation error or something'}
      response = OpenStruct.new(:status => 422, :body => body)
      client.parse_response(response).should == body
    end
  end

  context 'with a non-cortex error response' do
    it 'should return a wrapped response' do
      body = 'Catastrophic error'
      response = OpenStruct.new(:status => 500, :body => body)
      parsed = client.parse_response(response)
      parsed.error.should == body
      parsed.status.should == 500
      parsed.original.should == response
    end
  end

  context 'with a successful response' do
    it 'should return the parsed body' do
      body = {:id => 1, title: 'A post'}
      response = OpenStruct.new(:status => 200, :body => body)
      client.parse_response(response).should == body
    end
  end
end
