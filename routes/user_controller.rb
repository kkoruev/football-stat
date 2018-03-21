require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    get '/' do
      "Hello from User!"
    end

    post '/register' do
      request_params = JSON.parse(request.body.read)
      user = UserDeserializer.new(request_params).registration_data
      p user
    end

    post '/login' do
      p params
      p "hereee"
      p params
    end

    get '/login' do
      p params
    end
  end
end