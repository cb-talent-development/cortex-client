require 'spec_helper'

describe Cortex::Request do
  let(:client) { Cortex::Client.new(access_token: '123') }

  context 'with a cortex error response' do
    it 'should return the error object' do
      body = {'error' => 'Validation error or something'}
      response = OpenStruct.new(status: 422, body: body, headers: { :whatever => "Whatever"})
      expect(client.parse_response(response).to_h).to eq({ :body => body, :headers => {status: 422}})
    end
  end

  context 'with a non-cortex error response' do
    it 'should return a wrapped response' do
      body = 'Catastrophic error'
      response = OpenStruct.new(status: 500, body: body, headers: { whatever: "Whatever", status: 500 } )
      parsed = client.parse_response(response)
      expect(parsed.body[:error]).to eq(body)
      expect(parsed.body[:status]).to eq(500)
      expect(parsed.body[:original]).to eq(response)
      expect(parsed.headers[:status]).to eq(500)
    end
  end

  context 'with a successful response' do
    it 'should return the parsed body' do
      body = {:id => 1, title: 'A post'}
      response = OpenStruct.new(status: 200, body: body, headers: { :whatever => "Whatever" })
      expect(client.parse_response(response).to_h).to eq({ body: body, headers: {status: 200}})
    end
  end
end
