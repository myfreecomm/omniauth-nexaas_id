require 'spec_helper'

describe OmniAuth::Strategies::NexaasID do
  subject do
    described_class.new(
      'app_id',
      'app_secret',
      client_options: { site: 'https://sandbox.id.nexaas.com' })
  end

  it 'has a default scope' do
    expect(described_class::DEFAULT_SCOPE).to eq('profile invite')
  end

  it 'us a subclass of OmniAuth::Strategies::OAuth2' do
    expect(described_class.superclass).to eq(OmniAuth::Strategies::OAuth2)
  end

  it 'has app' do
    expect(subject.app).to eq('app_id')
  end

  it 'has a name' do
    expect(subject.name).to eq(:nexaas_id)
  end

  it 'has a site' do
    expect(subject.options[:client_options][:site]).to eq('https://sandbox.id.nexaas.com')
  end

  it 'has a nil api_token before build token' do
    expect(subject.api_token).to be_nil
  end
end
