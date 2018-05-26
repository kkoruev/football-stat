require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    include ErrorMessages

    get '/admin' do
      "Hello from Admin!"
    end

    post '/matches/predict' do
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

    get '/matches/predict' do
      matches = DBModels::Match.current
      Match::MatchesSerializer.new.matches_for_prediction(matches)
    end

    post '/matches/result' do
      # update matches results in the DB
      # update user points based on predicted matches
    end

    delete '/matches' do
      puts params
      "DELETION"
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
