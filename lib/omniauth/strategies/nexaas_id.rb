require 'omniauth-oauth2'

OmniAuth.config.add_camelization('nexaas_id', 'NexaasID')

module OmniAuth
  module Strategies
    class NexaasID < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'profile invite'.freeze

      attr_reader :api_token

      def initialize(*args)
        super
        @api_token = nil
      end

      option :name, :nexaas_id
      option :client_options, site: 'https://id.nexaas.com'

      uid do
        raw_info['id']
      end

      info do
        {
          id: raw_info['id'],
          name: {
            first: raw_info['first_name'],
            last: raw_info['last_name']
          },
          fullname: raw_info['full_name'],
          email: raw_info['email'],
          picture_url: raw_info['picture']
        }
      end

      extra do
        {
          raw_info: raw_info,
          legacy: { api_token: api_token }
        }
      end

      # Example:
      #
      #   {
      #     "id"=>"e9fa918b-a90e-49f3-86ec-e3ce92488a3e",
      #     "full_name"=>"John Doe",
      #     "email"=>"john@doe.com",
      #     "emails"=>[{"address"=>"john@doe.com", "confirmed"=>true}],
      #     "created_at"=>"2016-07-21T22:02:17Z",
      #     "updated_at"=>"2016-07-21T22:02:17Z",
      #     "_links"=>{
      #       "self"=>{
      #         "href"=>"https://id.nexaas.com/api/v1/users/e9fa918b-a90e-49f3-86ec-e3ce92488a3e"
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

      protected

      def build_access_token
        @api_token = request.params['api_token']
        super
      end
    end
  end
end
