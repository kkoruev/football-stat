require 'json'

require_relative '../lib/user/user_deserializer'
require_relative '../lib/team/team_deserializer'
require_relative '../lib/match/matches_deserializer'

require_relative '../lib/match/matches_serializer'
require_relative '../lib/team/team_serializer'

require_relative '../lib/user/error_messages'
require_relative '../lib/exceptions/login_authentication_error'

require_relative '../lib/user/user_functions'


module Routes
  # Routes base class that inherits from Sinatra base.
  class ApplicationController < Sinatra::Base
    use Rack::MethodOverride
    not_found do
      'This page does not exists!'
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    options '*' do
      response.headers['Allow'] = 'GET, POST, OPTIONS, PUT, DELETE'
      response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
      response.headers['Access-Control-Allow-Origin'] = '*'
      200
    end
  end
end
