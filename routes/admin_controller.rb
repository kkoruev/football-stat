require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    get '/admin' do
      "Hello from Admin!"
    end

    post '/matches' do
      "dasdas"
      request_params = JSON.parse(request.body.read)
      p request_params
      puts request_params
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
