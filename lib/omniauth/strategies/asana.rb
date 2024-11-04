# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Asana < OmniAuth::Strategies::OAuth2 # rubocop:disable Style/Documentation
      option :name, "asana"

      option :client_options, {
        site: "https://app.asana.com",
        authorize_url: "https://app.asana.com/-/oauth_authorize",
        token_url: "https://app.asana.com/-/oauth_token"
      }

      def authorize_params
        super.tap do |params|
          %w[client_options].each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end

      uid { raw_info["data"]["gid"] }

      info do
        {
          name: raw_info["data"]["name"],
          email: raw_info["data"]["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("https://app.asana.com/api/1.0/users/me").parsed
      end

      private

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization "asana", "Asana"
