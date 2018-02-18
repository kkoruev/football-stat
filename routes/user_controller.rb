require_relative "./application_controller"

module Routes
  class UserController < ApplicationController
    get '/' do
      "Hello from User!"
    end
  end
end