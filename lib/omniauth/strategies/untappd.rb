require 'omniauth-oauth2'

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
        @raw_info ||= access_token.get('http://api.untappd.com/v4/user/info').parsed['response']['user']
      end

      private

      def user_name
        "#{raw_info['first_name']} #{raw_info['last_name']}"
      end
    end
  end
end

module OAuth2
  class UntappdClient < OAuth2::Client
    def get_token(params, access_token_opts={}, access_token_class = AccessToken)
      opts = { raise_errors: options[:raise_errors], parse: params.delete(:parse), params: params }
      response = request(options[:token_method], token_url, opts)
      untappd_response = response.parsed['response']
      raise Error.new(response) if options[:raise_errors] && !(untappd_response.is_a?(Hash) && untappd_response['access_token'])
      access_token_class.from_hash(self, untappd_response.merge(access_token_opts))
    end
  end
end
