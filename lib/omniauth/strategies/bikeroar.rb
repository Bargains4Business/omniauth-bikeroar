require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bikeroar < OmniAuth::Strategies::OAuth2
      option :name, 'bikeroar'
      option :client_options, {
        :site => 'https://wwww.bikeroar.com',
        :authorize_path => '/oauth/new',
        :token_path => '/oauth/token'
      }
      option :scope, 'public'

      def authorize_params
        super
      end

      def request_phase
        super
      end

      def callback_phase
        super
      end

      uid { member['uuid'] }

      extra do
        { raw_info: member }
      end

      info do
        {
          email: member['email'],
          first_name: member['first_name'],
          # https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
          # A URL representing a profile image of the authenticating user. Where possible, should be specified to a square, roughly 50x50 pixel image
          image: member['avatar_url'],
          last_name: member['last_name'],
          location: "#{member['city']}, #{member['state']}}",
          name: "#{member['first_name']} #{member['last_name']}",
          nickname: member['username'],
        }
      end

      def raw_info
        access_token.options[:parse] = :json
        @raw_info ||= access_token.get('/member', { access_token: access_token.token }).parsed
      end
    end
  end
end
