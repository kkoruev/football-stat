require 'json'
require 'securerandom'

require_relative '../lib/user/user_deserializer'
require_relative '../lib/team/team_deserializer'
require_relative '../lib/match/matches_deserializer'

require_relative '../lib/match/matches_serializer'
require_relative '../lib/team/team_serializer'
require_relative '../lib/user/user_serializer'

require_relative '../lib/user/error_messages'

require_relative '../lib/exceptions/login_authentication_error'
require_relative '../lib/exceptions/team_not_found_error'

require_relative '../lib/user/user_functions'
require_relative '../lib/match/result'


module Routes
  # Routes base class that inherits from Sinatra base.
  class ApplicationController < Sinatra::Base
    use Rack::MethodOverride
    enable :sessions
    set :session_secret, "SECRET123"

    helpers do
      def request_headers
        env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
      end
    end

    not_found do
      'This page does not exists!'
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Expose-Headers'] = 'X-Auth-Token'
    end

    options '*' do
      response.headers['Allow'] = 'GET, POST, DELETE, OPTIONS, PUT'
      response.headers['Access-Control-Allow-Methods'] = 'GET, POST, DELETE, OPTIONS, PUT'
      response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
      response.headers['Access-Control-Allow-Origin'] = '*'
      200
    end
  end
end
