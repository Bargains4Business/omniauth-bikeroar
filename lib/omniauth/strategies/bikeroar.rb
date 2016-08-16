require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bikeroar < OmniAuth::Strategies::OAuth2
      option :name, 'bikeroar'
      option :client_options, {
        :site          => 'http://wwww.bikeroar.com',
        :authorize_url => 'http://wwww.bikeroar.com/oauth/authorize',
        :token_url     => 'http://wwww.bikeroar.com/oauth/token',
        :callback_path => "/auth/bikeroar/callback"
      }
      option :scope, 'public'

      uid { raw_info['uuid'] }

      extra do
        { raw_info: raw_info }
      end

      info do
        {
          email: raw_info['email'],
          first_name: raw_info['first_name'],
          # https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
          # A URL representing a profile image of the authenticating user. Where possible, should be specified to a square, roughly 50x50 pixel image
          image: raw_info['full_thumbnail_url'],
          last_name: raw_info['last_name'],
          location: [raw_info['city'], raw_info['state']].compact.join(', '),
          name: "#{raw_info['first_name']} #{raw_info['last_name']}",
          nickname: raw_info['username'],
        }
      end

      def raw_info
        access_token.options[:parse] = :json
        @raw_info ||= access_token.get('/api/v1/members/me', { access_token: access_token.token }).parsed
      end
    end
  end
end
