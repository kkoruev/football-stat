require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    include ErrorMessages

    get '/admin' do
      "Hello from Admin!"
    end

    post '/matches' do
      request_params = JSON.parse(request.body.read)
      matches = Match::MatchesDeserializer.new.matches_for_predicting(request_params)
      matches.each do |match|
        begin
          match.save
        rescue DataMapper::SaveFailureError => ex
          halt 400, match_not_saved(match)
        end
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

    post '/matches/:match/results' do |match|
      request_params = parse_params(request.body.read)
      halt 400, parse_error if request_params.empty?

      result = Match::MatchesDeserializer.result(request_params)
      halt 400, "Result error" if result.empty?

      all_predictions = DBModels::Predictions.new.matches_by_id(match)
      halt 400, "No predictions for this match" if all_predictions.empty?
      # iterate through all predictions and find the result and points
      all_predictions.each do |prediciton|
        # prediction.calculate_points(result)
      end
    end

    delete '/matches/:gameweek' do |gameweek|
      matches = DBModels::Match.gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?
      halt 400, could_not_delete_matches(gameweek) unless matches.destroy
    end

    get '/teams' do
      Team::TeamSerializer.new.teams_json(DBModels::Team.all)
    end

    put '/teams/:name' do |name|
      team = DBModels::Team.new
      team.name = name
      begin
        team.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, team_not_saved(name)
      end
    end

    get '/adminTasks' do
      "Post matches for predicting </br>
      Update matches results </br>
      "
    end
  end
end
