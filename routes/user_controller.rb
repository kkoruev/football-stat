require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    include ErrorMessages
    include UserFunctions

    get '/' do
      "Hello from User!"
    end

    post '/register' do
      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?
      user = UserDeserializer.new(request_params).registration_data
      halt 400, user_exist(user.email) if user.exists?
      begin
        user.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, user_not_saved(user)
      end
    end

    post '/login' do
      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?
      user, password = UserDeserializer.new(request_params).login_data
      halt 400, parse_error if password.nil?
      begin
        user = user.authenticate(password)
      rescue LoginAuthenticationError => ex
        halt 400, ex.message
      end
      "Succeed"
    end

    get '/matches' do
      matches = DBModels::Match.new.current
      Match::MatchesSerializer.new.matches_for_prediction(matches)
    end

    post '/predictions'
      # prediction_for_match
      # {
      #   match_id,
      #   h_s,
      #   a_s
      # }
      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?
      prediction = Match::MatchesDeserializer.new.prediction(request_params)
      p prediction
      "dsad"
    end

    get '/login' do
      p params
    end

    get '/userTasks' do
      h = { :matches_prediction => "Get all available matches for prediction",
            :standing => "Get user standings",
            :points_from_matches => "All predicted matches",
            :update_profile => "Updating profile info" }
    end

    get '/test' do
      user = DBModels::User.new
      user.email = "lok"
      user = user.authenticate("2")
      "YOU ARE LOGGED IN"
    end

  end
end
