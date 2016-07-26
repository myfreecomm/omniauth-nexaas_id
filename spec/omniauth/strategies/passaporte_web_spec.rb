require 'spec_helper'

describe OmniAuth::Strategies::PassaporteWeb do
  subject { described_class.new('app_id', 'app_secret') }
  it 'has a default scope' do
    expect(described_class::DEFAULT_SCOPE).to eq('public')
  end
  it 'us a subclass of OmniAuth::Strategies::OAuth2' do
    expect(described_class.superclass).to eq(OmniAuth::Strategies::OAuth2)
  end
  it 'has a name' do
    expect(subject.name).to eq(:passaporte_web)
  end
end
