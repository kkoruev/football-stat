module Routes
  class ApplicationController < Sinatra::Base

    not_found do
      "This page does not exists!"
    end

  end
end