require_relative '../../../../spec_helper'

describe Cortex::Client::Resources::ResourceBase do
  let(:v1) { 'v1' }
  let(:apis) { { v1: v1 } }
  let(:options) { 'options' }

  describe :initialize do
    it 'sets the v1 to the passed value' do
      client = Cortex::Client::Resources::ResourceBase.new(apis, nil)
      expect(client.instance_variable_get(:@v1)).to eq('v1')
    end

    it 'sets the options to the passed value' do
      client = Cortex::Client::Resources::ResourceBase.new([], options)
      expect(client.instance_variable_get(:@options)).to eq('options')
    end
  end

  describe :client do
    it 'calls the v1 client' do
      v1 = double()
      expect(v1).to receive(:client)
      apis = { v1: v1 }

      client = Cortex::Client::Resources::ResourceBase.new(apis, nil)
      client.client
    end
  end
end