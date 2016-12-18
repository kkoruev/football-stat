require 'sinatra'

Dir.glob('%s/routes/*.rb' % Dir.pwd).each do |file|
  require_relative file
end
