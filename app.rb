require 'sinatra'
require 'sinatra/cookies'
require 'data_mapper'
require 'dm-noisy-failures'

require_relative './config/database'
require_relative './config/environment'


Dir.glob('%s/routes/*.rb' % Dir.pwd).each do |file|
  require_relative file
end

#Initialize admin account
def add_admin_account
  admin_account = "admin@predicitons.com"
  User::Register.register("admin", admin_account, "admin", 1);
end

add_admin_account

