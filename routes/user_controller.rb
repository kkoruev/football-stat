require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    include ErrorMessages
    include UserFunctions

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
        session = DBModels::Session.new.user_session(user.email)
        token = session.update_token unless session.nil?
        response.headers['X-Auth-Token'] = token unless token.nil?
        halt 200, user.user_role_text unless token.nil?

        token = DBModels::Session.new.generate_token(user.email, user.id)
        response.headers['X-Auth-Token'] = token
        halt 200, user.user_role_text
      rescue LoginAuthenticationError => ex
        halt 400, ex.message
      end
    end

    get '/matches' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Admin can not open this page" if user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      matches = DBModels::Match.new.current
      predictions = DBModels::Prediction.new.current_predictions_by_user(id)
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

      response.headers['X-Auth-Token'] = session.update_token
      Match::MatchesSerializer.new.matches_for_prediction(current_matches)
    end

    post '/predictions' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Admin can not open this page" if user.admin?

      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?
      prediction = Match::MatchesDeserializer.new.prediction(request_params)
      prediction.user_id = id
      begin
        prediction.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, prediction_save_error
      end
    end

    get '/predictions' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Admin can not open this page" if user.admin?

      predictions = DBModels::Prediction.new.predicted_matches(id)
      Match::MatchesSerializer.new.predictions(predictions)
    end

    get '/standing' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Admin can not open this page" if user.admin?

      UserSerializer.new.standing(user.users_standing)
    end

    get '/statistics' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Admin can not open this page" if user.admin?

      all_predictions = DBModels::Match.new.all_predictions_for_current
      Match::MatchesSerializer.new.statistics(all_predictions)
    end

  end
end
