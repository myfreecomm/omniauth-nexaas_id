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
    end
  end
end
