require 'spec_helper'

describe OmniAuth::Strategies::NexaasIDPasswordless do
  subject do
    described_class.new(
      'app',
      'app_id',
      'app_secret',
      client_options: { site: 'https://sandbox.id.nexaas.com',
                        passwordless_token: 'token-123' },
      list_emails: true
    )
  end

  it 'has a default scope' do
    expect(described_class::DEFAULT_SCOPE).to eq('profile invite')
  end

  it 'us a subclass of OmniAuth::Strategies::OAuth2' do
    expect(described_class.superclass).to eq(OmniAuth::Strategies::OAuth2)
  end

  it 'has app' do
    expect(subject.app).to eq('app')
  end

  it 'has a name' do
    expect(subject.name).to eq(:nexaas_id_passwordless)
  end

  it 'has a site' do
    expect(subject.options[:client_options][:site]).to eq('https://sandbox.id.nexaas.com')
  end

  it 'must be true list_emails' do
    expect(subject.list_emails?).to be_truthy
  end

  it 'has a passwordless_token' do
    expect(subject.options[:client_options][:passwordless_token]).to eq('token-123')
  end

  it 'has a authorize_url default' do
    expect(subject.options[:client_options][:authorize_url]).to eq('oauth/passwordless/authorize')
  end

  describe '#authorize_params' do
    it 'returns state and passwordless_token' do
      expect(subject.authorize_params[:state]).to be_an_instance_of(String)
      expect(subject.authorize_params[:state]).to_not be_empty
      expect(subject.authorize_params[:passwordless_token]).to eq('token-123')
    end
  end

  describe '#request_phase' do
    before do
      expect_any_instance_of(OmniAuth::Strategies::OAuth2).to receive(:callback_url).and_return('callback_url')
    end

    it 'redirect to oauth/passwordless/authorize' do
      code, env = subject.request_phase

      expect(code).to eq(302)
      expect(env['Location']).to match(
        %r{sandbox.id.nexaas.com/oauth/passwordless/authorize\?client_id=app_id&passwordless_token=token-123&redirect_uri=callback_url}
      )
    end
  end
end
