require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    get '/admin' do
      "Hello from Admin!"
    end

    post '/matches' do

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