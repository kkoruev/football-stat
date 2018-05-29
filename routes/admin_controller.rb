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

    post '/matches/:gameweek/results' do
      matches = DBModels::Match.matches_from_gameweek(gameweek)
      halt 400, no_such_gameweek(gameweek) if matches.empty?

      # match{
      #   id = 1
      #   h_t_n ..
      #   ..
      # }
      #
      # result{
      #   id = 1
      #   h_t_s = 1
      #   a_t_s = 2
      # }
      #
      # prediction{
      #   id = 1
      #   h_t_s = 1
      #   a_t_s = 2
      #   user_id = ?
      #   match_id = ?
      # }

      # get all predictions based on match_id
      # sum points for all predictions and update user table with summed points
      # update matches results in the DB
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
