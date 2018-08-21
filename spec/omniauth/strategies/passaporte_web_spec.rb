require 'spec_helper'

describe OmniAuth::Strategies::PassaporteWeb do
  subject do
    described_class.new(
      'app_id',
      'app_secret',
      client_options: { site: 'https://sandbox.v2.passaporteweb.com.br' })
  end

  it 'has a default scope' do
    expect(described_class::DEFAULT_SCOPE).to eq('profile')
  end
  it 'us a subclass of OmniAuth::Strategies::OAuth2' do
    expect(described_class.superclass).to eq(OmniAuth::Strategies::OAuth2)
  end
  it 'has a name' do
    expect(subject.name).to eq(:passaporte_web)
  end
  it 'has a site' do
    expect(subject.options[:client_options][:site]).to eq('https://sandbox.v2.passaporteweb.com.br')
  end
end
