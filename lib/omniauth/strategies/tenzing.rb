require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Tenzing < OmniAuth::Strategies::OAuth2
      option :name, "tenzing"

      option :client_options, {
        :site => 'http://id.tenzing.urbegi.com',
        :token_url => '/oauth/access_token',
        :authorize_url => '/oauth/authorize'
      }

      uid { raw_info['_id'] }

      info do
        {
          :email => raw_info['email'],
          :name => raw_info['name']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get("/api/v1/user_info").body)
      end

      def request_phase
        super
      end

    end
  end
end

OmniAuth.config.add_camelization 'tenzing', 'Tenzing'

