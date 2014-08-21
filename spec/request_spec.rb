require 'spec_helper'

describe Cortex::Request do
  let(:client) { Cortex::Client.new(access_token: '123') }

  before(:context) do
    connection = stub
    connection.stubs(:get).returns(OpenStruct.new({body: "Body", headers: {}, status: 200} ) )

    Cortex::Client.any_instance.stubs(:connection).returns(connection)
  end

  describe 'get' do
    it 'should work' do
      client.get('/test/')
    end
  end

  context 'with a non-cortex error response' do
    it 'should return a wrapped response' do
      body = 'Catastrophic error'
      response = OpenStruct.new(status: 500, body: body, headers: { whatever: "Whatever", status: 500 } )
      parsed = client.parse_response(response)
      expect(parsed.contents).to eq(body)
      expect(parsed.raw_headers[:status]).to eq(500)
    end
  end

  context 'with a successful response' do
    it 'should return the parsed body' do
      body = {:id => 1, title: 'A post'}
      response = OpenStruct.new(status: 200, body: body, headers: { :whatever => "Whatever" })
      expect(client.parse_response(response)).to eq({ body: body, headers: {status: 200}})
    end
  end
end
