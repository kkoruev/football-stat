require 'sinatra/base'
require 'rubygems'

require_relative './routes/user_controller'
require_relative './routes/admin_controller'

require_relative './config/database'
require_relative './config/environment'

Config::Database.new.setup
Config::Environment.new.setup(false)

map('/') { run Routes::UserController }
map('/admin') { run Routes::AdminController }
