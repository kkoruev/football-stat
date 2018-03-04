require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    get '/' do
      "Hello from User!"
    end

    post '/register' do
      p params
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