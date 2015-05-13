require_relative '../../../../spec_helper'

describe Cortex::Client::APIs::APIBase do
  let(:faraday_options) {
    {
      faraday_adapter: :test
      # faraday_params: 'params here'
    }
  }
  let(:options) {
    {
      connection_options: {},
      oauth_options: {
        oauth_adapter: Cortex::Client::Mocks::OAuth
      },
      faraday_options: faraday_options
    }
  }

  subject { Cortex::Client::APIs::APIBase.new(options) }

  describe :initialize do
    it 'sets the options instance variables correctly' do
      expect(subject.instance_variable_get(:@oauth_options)).to eq({oauth_adapter: Cortex::Client::Mocks::OAuth})
      expect(subject.instance_variable_get(:@faraday_options)).to eq({faraday_adapter: :test})
      expect(subject.instance_variable_get(:@connection_options)).to eq({})
    end
  end

  describe :oauth_client do
    it 'returns an instance of the initalized OAuth Client' do
      expect(subject.oauth_client).to be_an_instance_of(Cortex::Client::Mocks::OAuth)
    end

    it 'sets the default oauth adapter' do
      client = Cortex::Client::APIs::APIBase.new();
      expect(client.oauth_client).to be_an_instance_of(Cortex::Client::OAuth)
    end
  end
end