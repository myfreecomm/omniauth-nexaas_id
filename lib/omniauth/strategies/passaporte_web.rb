module OmniAuth
  module Strategies
    class PassaporteWeb < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'public'

      option :name, :passaporte_web

      option :client_options, {
        :site => 'https://app.passaporteweb.com.br',
        :authorize_path => '/oauth/authorize',
        :token_path => '/oauth/token',
        :token_method => :post,
        :raise_errors => true,
      }

      uid do
        raw_info['id']
      end

      info do
        {
          :id => raw_info['id'],
          :name => raw_info['name'],
          :email => raw_info['email'],
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      # Example:
      #
      #   {
      #     "id"=>"e9fa918b-a90e-49f3-86ec-e3ce92488a3e",
      #     "name"=>"John Doe",
      #     "email"=>"john@doe.com",
      #     "created_at"=>"2016-07-21T22:02:17Z",
      #     "updated_at"=>"2016-07-21T22:02:17Z",
      #     "_links"=>{
      #       "self"=>{
      #         "href"=>"https://app.passaporteweb.com.br/api/v1/users/e9fa918b-a90e-49f3-86ec-e3ce92488a3e"
      #       }
      #     }
      #   }
      def raw_info
        @raw_info ||= access_token.get('/api/v1/profile').parsed
      end

      def request_phase
        options[:authorize_params] = {
          :client_id => options['client_id'],
          :response_type => 'code',
          :scopes => (options['scope'] || DEFAULT_SCOPE)
        }
        super
      end
    end
  end
end
