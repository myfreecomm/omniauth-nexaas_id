module OmniAuth
  module Strategies
    class PassaporteWeb < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'public'

      option :name, :passaporte_web

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://app.passaporteweb.com.br',
        :authorize_path => '/oauth/authorize',
        :token_path => '/oauth/token',
        :token_method => :post,
        :raise_errors => true,
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid do
        raw_info['id']
      end

      info do
        {
          :name => raw_info['name'],
          :email => raw_info["email"]
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        # @raw_info ||= access_token.get('/api/v1/profile').parsed
        {'id' => 42, 'name' => 'Quarenta e Dois', 'email' => 'qua@renta.dois'}
      end

      def request_phase
        options[:authorize_params] = {
          :client_id     => options['client_id'],
          :response_type => 'code',
          :scopes        => (options['scope'] || DEFAULT_SCOPE)
        }
        super
      end
    end
  end
end
