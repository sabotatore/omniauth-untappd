require 'omniauth/strategies/oauth2'
require 'oauth2/untappd_client'

module OmniAuth
  module Strategies
    class Untappd < OmniAuth::Strategies::OAuth2
      option :name, 'untappd'
      option :provider_ignores_state, true

      option :client_options, {
        site: 'https://untappd.com',
        authorize_url: '/oauth/authenticate',
        token_url: '/oauth/authorize',
        token_method: :get
      }

      option :token_params, {
        parse: :json
      }

      uid { raw_info['id'] }

      info do
        {
          name:        user_name,
          email:       raw_info['settings']['email_address'],
          nickname:    raw_info['user_name'],
          first_name:  raw_info['first_name'],
          last_name:   raw_info['last_name'],
          location:    raw_info['location'],
          description: raw_info['bio'],
          image:       raw_info['user_avatar'],
          urls:        { 'Untappd' => raw_info['untappd_url'],
                         'Website' => raw_info['url'] }
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def client
        ::OAuth2::UntappdClient.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
      end

      def authorize_params
        options.authorize_params[:redirect_url] = callback_url
        super
      end

      def token_params
        options.token_params[:redirect_url] = callback_url
        super
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = :access_token
        @raw_info ||= access_token.get('https://api.untappd.com/v4/user/info').parsed['response']['user']
      end

      private

      def user_name
        "#{raw_info['first_name']} #{raw_info['last_name']}"
      end
    end
  end
end
