# frozen_string_literal: true

require_relative 'nexaas_id'

OmniAuth.config.add_camelization('nexaas_id_passwordless', 'NexaasIDPasswordless')

module OmniAuth
  module Strategies
    class NexaasIDPasswordless < OmniAuth::Strategies::NexaasID

      option :name, :nexaas_id_passwordless
      option :client_options, site: 'https://id.nexaas.com',
                              authorize_url: '/oauth/passwordless/authorize'

      def authorize_params
        options.authorize_params[:passwordless_token] = options[:client_options][:passwordless_token]
        super
      end

      private

      def callback_url
        uri = URI.parse(super)
        new_query = URI.decode_www_form(uri.query).reject { |query| query[0] == 'passwordless_token' }
        uri.query = new_query.empty? ? nil : URI.encode_www_form(new_query)
        uri.to_s
      end
    end
  end
end
