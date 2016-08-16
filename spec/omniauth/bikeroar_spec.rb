require 'spec_helper'
require 'omniauth-bikeroar'

describe OmniAuth::Strategies::Bikeroar do
  subject do
    strategy = OmniAuth::Strategies::Bikeroar.new(nil, @options || {})
    strategy.stub(:session) { {} }
    strategy
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'should have the correct bikeroar site' do
      expect(subject.client.site).to eq("http://wwww.bikeroar.com")
    end

    it 'should have the correct authorization url' do
      expect(subject.client.options[:authorize_url]).to eq("http://wwww.bikeroar.com/oauth/authorize")
    end

    it 'should have the correct token url' do
      expect(subject.client.options[:token_url]).to eq('http://wwww.bikeroar.com/oauth/token')
    end
  end

  describe '#callback_path' do
    it 'should have the correct callback path' do
      expect(subject.callback_path).to eq('/auth/bikeroar/callback')
    end
  end
end
