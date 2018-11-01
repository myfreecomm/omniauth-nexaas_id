require 'omniauth-oauth2'

OmniAuth.config.add_camelization('nexaas_id', 'NexaasID')

module OmniAuth
  module Strategies
    class NexaasID < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'profile invite'.freeze

      def initialize(*args)
        @api_token = nil
        super
      end

      option :name, :nexaas_id
      option :client_options, site: 'https://id.nexaas.com'
      option :list_emails, false

      uid do
        raw_info['id']
      end

      info do
        main_email = raw_info['email']
        {
          id: raw_info['id'],
          name: {
            first: raw_info['first_name'],
            last: raw_info['last_name']
          },
          fullname: raw_info['full_name'],
          email: main_email,
          emails: raw_info['emails'] || [main_email],
          picture_url: raw_info['picture']
        }
      end

      extra do
        {
          raw_info: raw_info,
          legacy: { api_token: @api_token }
        }
      end

      def raw_info
        @raw_info ||= build_raw_info
      end

      def request_phase
        options[:authorize_params][:scopes] = options['scope'] || DEFAULT_SCOPE
        super
      end

      def list_emails?
        options[:list_emails] || options['list_emails'] ||
          options[:client_options][:list_emails]
      end

      protected

      def build_access_token
        if (token = super) && token.params
          @api_token = token.params['api_token']
        end
        token
      end

      def build_raw_info
        add_email_list_to(access_token.get('/api/v1/profile').parsed)
      end

      def add_email_list_to(acc)
        acc['emails'] = retrieve_emails(acc['id'])
        acc
      end

      def retrieve_emails(id)
        return unless list_emails? # guard: access endpoint only if allowed
        emails = access_token.get('/api/v1/profile/emails').parsed
        got = emails['id']
        raise "unexpected id #{got} retrieving e-mails for #{id}" unless got == id
        emails['emails']

      rescue StandardError => err
        warn(err)
        nil
      end
    end
  end
end
