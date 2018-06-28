require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    include ErrorMessages
    include UserFunctions

    get '/admin' do
      "Hello from Admin!"
    end

    post '/matches' do
      request_params = JSON.parse(request.body.read)
      match = Match::MatchesDeserializer.new.match_for_prediction(request_params)
      begin
        match.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, match_not_saved(match)
      end
    end

    get '/matches' do
      matches = DBModels::Match.new.current
      Match::MatchesSerializer.new.matches_for_prediction(matches)
    end

    get '/matches/:gameweek' do
      matches = DBModels::Match.new.matches_from_gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?

    end

    ## TODO: Failing when trying to update user points - fix it
    post '/matches/:match/results' do |match|
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
      matches = DBModels::Match.gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?
      halt 400, could_not_delete_matches(gameweek) unless matches.destroy
    end

    get '/teams' do
      Team::TeamSerializer.new.teams_json(DBModels::Team.all)
    end

    post '/teams' do
      request_params = parse_params(request.body.read)
      team = Match::MatchesDeserializer.new.team(request_params)
      begin
        team.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, team_not_saved(team.name)
      end
    end

    delete '/teams/:team_name' do |team_name|
      begin
        DBModels::Team.new.remove_team(team_name)
      rescue TeamNotFoundError => ex
        halt 400, ex.message
      end
    end

    get '/adminTasks' do
      "Post matches for predicting </br>
      Update matches results </br>
      "
    end
  end
end
