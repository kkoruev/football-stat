require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    include ErrorMessages

    get '/admin' do
      "Hello from Admin!"
    end

    post '/predict/matches' do
      request_params = JSON.parse(request.body.read)
      matches = MatchesDeserializer.new(request_params).matches_for_predicting
      matches.each do |match|
        begin
          match.save
        rescue DataMapper::SaveFailureError => ex
          halt 400, match_not_saved(match)
        end
      end
    end

    get '/predict/matches' do
      p "HEREEEEEEEEEEEEEEE"
      matches = DBModels::Match.current
      MatchesSerializer.new.matches_for_prediction(matches)
    end

    get '/teams' do

    end

    post '/team' do

    end

    get '/adminTasks' do
      "Post matches for predicting </br>
      Update matches results </br>
      "
    end
  end
end
