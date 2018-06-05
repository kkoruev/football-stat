require 'sinatra/base'
require 'sinatra/cors'
require 'sinatra/cross_origin'

require 'rubygems'
require 'data_mapper'
require 'dm-noisy-failures'
require 'dm-validations'
require 'dm-aggregates'

require_relative './routes/user_controller'
require_relative './routes/admin_controller'

require_relative './config/database'
require_relative './config/environment'

Config::Database.new.setup
Config::Environment.new.setup(false)
DBModels::User.new.create_default_admin


map('/') { run Routes::UserController }
map('/admin') { run Routes::AdminController }

# register
# login
