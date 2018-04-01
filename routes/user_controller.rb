require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    include UserErrorMessages

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
        p "Here"
        halt 400, user_not_saved(user)
      end
    end

    get '/test' do
      user = DBModels::User.new
      user.email = "lok"
      user = user.authenticate("1")
      "YOU ARE LOGGED IN"
    end

    post '/login' do
      request_params = JSON.parse(request.body.read)
      user = UserDeserializer.new(request_params).login_data
      
    end

    get '/login' do
      p params
    end
  end
end