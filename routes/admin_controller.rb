require_relative "./application_controller"

module Routes
  class AdminController < ApplicationController
    get '/admin' do
      "Hello from Admin!"
    end
  end
end