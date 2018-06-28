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
    end

    get '/matches' do
      user_id = 16
      matches = DBModels::Match.new.current
      predictions = DBModels::Prediction.new.current_predictions_by_user(user_id)
      current_matches = []
      # TODO: MOVE IT TO FUNCTION!
      matches.each do |match|
        found = false
        predictions.each do |prediction|
          found = match.id == prediction.match_id
          break if found
        end
        current_matches.push(match) unless found
      end

      Match::MatchesSerializer.new.matches_for_prediction(current_matches)
    end

    post '/predictions' do
      user_id = 2
      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?
      prediction = Match::MatchesDeserializer.new.prediction(request_params)
      prediction.user_id = user_id
      begin
        prediction.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, prediction_save_error
      end
    end

    get '/predictions' do
      user_id = 2
      # TODO: Should make session based on cookies
      predictions = DBModels::Prediction.new.predicted_matches(user_id)
      Match::MatchesSerializer.new.predictions(predictions)
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
      match = DBModels::Match.new.match_by_id(3)
      p match
      "Here"
    end

  end
end
