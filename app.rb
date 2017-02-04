require 'sinatra'
require 'sinatra/cookies'
require 'data_mapper'

require_relative './config/database'
require_relative './config/environment'


Dir.glob('%s/routes/*.rb' % Dir.pwd).each do |file|
  require_relative file
end

