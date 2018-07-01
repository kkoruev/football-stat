require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    include ErrorMessages
    include UserFunctions
    
    post '/matches' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      request_params = JSON.parse(request.body.read)
      match = Match::MatchesDeserializer.new.match_for_prediction(request_params)
      begin
        match.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, match_not_saved(match)
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
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      matches = DBModels::Match.new.current
      Match::MatchesSerializer.new.matches_for_prediction(matches)
    end

    get '/matches/:gameweek' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      matches = DBModels::Match.new.matches_from_gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?
    end

    ## TODO: Failing when trying to update user points - fix it
    post '/matches/:match/results' do |match|
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?

      result = Match::MatchesDeserializer.new.result(request_params)
      halt 400, "Result error" if result.empty?

      all_predictions = DBModels::Prediction.new.matches_by_id(match)
      # iterate through all predictions and find the result and points
      all_predictions.each do |prediction|
        prediction.calculate_points(result)
      end

      id = match
      home_score = result.home_score
      away_score = result.away_score
      DBModels::Match.new.match_by_id(id).update_score(home_score, away_score)
    end

    delete '/matches/:gameweek' do |gameweek|
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      matches = DBModels::Match.gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?
      halt 400, could_not_delete_matches(gameweek) unless matches.destroy
    end

    get '/teams' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token
      Team::TeamSerializer.new.teams_json(DBModels::Team.all)
    end

    post '/teams' do
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      request_params = parse_params(request.body.read)
      team = Match::MatchesDeserializer.new.team(request_params)
      begin
        team.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, team_not_saved(team.name)
      end
    end

    delete '/teams/:team_name' do |team_name|
      token = request_headers['x_auth_token']
      halt 401, "Provide token" if token.nil?
      halt 401, "Session expired" if DBModels::Session.new.expired?(token)

      session = DBModels::Session.new.session(token)
      halt 401, "Wrong token" if session.nil?

      id = session.user_id
      user = DBModels::User.new.user(id)
      halt 403, "Only admin has acces to this resource" unless user.admin?

      token = session.update_token
      response.headers['X-Auth-Token'] = session.update_token

      begin
        DBModels::Team.new.remove_team(team_name)
      rescue TeamNotFoundError => ex
        halt 400, ex.message
      end
    end
  end
end
