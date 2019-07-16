require 'spec_helper'

describe OmniAuth::Strategies::NexaasIDPasswordless do
  subject do
    described_class.new(
      'app',
      'app_id',
      'app_secret',
      client_options: { site: 'https://sandbox.id.nexaas.com' },
      authorize_params: { passwordless_token: 'token-123' },
      list_emails: true
    )
  end

  it 'has a default scope' do
    expect(described_class::DEFAULT_SCOPE).to eq('profile invite')
  end

  it 'us a subclass of OmniAuth::Strategies::NexaasID' do
    expect(described_class.superclass).to eq(OmniAuth::Strategies::NexaasID)
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
    expect(subject.options[:authorize_params][:passwordless_token]).to eq('token-123')
  end

  it 'has a authorize_url default' do
    expect(subject.options[:client_options][:authorize_url]).to eq('/oauth/passwordless/authorize')
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
      allow_any_instance_of(OmniAuth::Strategies::OAuth2).to receive(:full_host).and_return('http://example.com')
      allow_any_instance_of(OmniAuth::Strategies::OAuth2).to receive(:script_name).and_return('')
      allow_any_instance_of(OmniAuth::Strategies::OAuth2).to receive(:callback_path).and_return('/auth/passwordless_token/callback')
      allow_any_instance_of(OmniAuth::Strategies::OAuth2).to receive(:query_string).and_return('?passwordless_token=token-123')
    end

    it 'redirect to oauth/passwordless/authorize' do
      code, env = subject.request_phase

      expect(code).to eq(302)
      expect(env['Location']).to match(
        %r{sandbox.id.nexaas.com/oauth/passwordless/authorize\?client_id=app_id&passwordless_token=token-123}
      )
    end

    it 'sets redirect_uri without passwordless_token param' do
      _code, env = subject.request_phase
      queries = URI.parse(env['Location']).query
      redirect_uri = URI.decode_www_form(queries).select { |query| query[0] == 'redirect_uri'}.flatten

      expect(redirect_uri[1]).to match('http://example.com/auth/passwordless_token/callback')
    end
  end
end
