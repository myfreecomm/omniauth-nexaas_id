require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class PassaporteWeb < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'profile'

      option :name, :passaporte_web
      option :client_options, { site: 'https://v2.passaporteweb.com.br' }

      uid do
        raw_info['id']
      end

      info do
        {
          id: raw_info['id'],
          name: raw_info['name'],
          email: raw_info['main_email'],
          picture_url: raw_info['picture']
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
      #     "main_email"=>"john@doe.com",
      #     "emails"=>[{"address"=>"john@doe.com", "confirmed"=>true}],
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
        options[:authorize_params][:scopes] = options['scope'] || DEFAULT_SCOPE
        super
      end
    end
  end
end
