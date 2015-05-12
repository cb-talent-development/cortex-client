require_relative '../../../../spec_helper'

describe Cortex::Client::APIs::V1 do
  let(:path) { '/path' }
  let(:oauth) do
    oauth_token = double()
    allow(oauth_token).to receive(:token).and_return 'token'
    Struct.new("OAuth", :options) do
      def token
        c = Struct.new("Token") do
          def token
            "token"
          end
        end
        c.new()
      end
    end
  end
  let(:options) {
    { faraday_adapter: :test,
      oauth_options: { oauth_adapter: oauth }
    }
  }

  describe :get do
    it 'makes the request to the proper url' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/path?access_token=token') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.get(path).body).to eq('ok')
    end
  end
end

describe Cortex::Client::APIs::V1::Endpoints do
    it { is_expected.to have_constant(:POST_FEED)   }
    it { is_expected.to have_constant(:SINGLE_ITEM) }
    it { is_expected.to have_constant(:PUBLISHED)   }
    it { is_expected.to have_constant(:RELATED)     }
    it { is_expected.to have_constant(:AUTHORS)     }
    it { is_expected.to have_constant(:FILTERS)     }
    it { is_expected.to have_constant(:USER_AUTHOR) }
end