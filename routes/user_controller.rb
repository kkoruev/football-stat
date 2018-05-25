require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    include ErrorMessages

    get '/' do
      "Hello from User!"
    end

    post '/register' do
      request_params = JSON.parse(request.body.read)
      user = UserDeserializer.new(request_params).registration_data
      halt(400, user_exist(user.email)) if user.exists?
      begin
        user.save
      rescue DataMapper::SaveFailureError => ex
        halt 400, user_not_saved(user)
      end
    end

    post '/login' do
      request_params = JSON.parse(request.body.read)
      user = UserDeserializer.new(request_params).login_data
      # begin
      #   user.authenticate
      # rescue

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
