require 'json'
require_relative '../lib/user/user_deserializer'


module Routes
  class ApplicationController < Sinatra::Base

    not_found do
      "This page does not exists!"
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    options "*" do
      response.headers["Allow"] = "GET, POST, OPTIONS, PUT, DELETE"
      response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
      response.headers["Access-Control-Allow-Origin"] = "*"
      200
    end

  end
end