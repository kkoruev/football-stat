require_relative '../lib/user/register'

get '/home' do
  erb :'shared/home'
end

get '/register' do
  erb :'user/register'
end

post '/register' do
  User::Register.register(params[:full_name], params[:email], params[:password])
end

get '/login' do
  erb :'user/login'
end

post '/login' do
  User::Register.login(params[:email], params[:password])
end

get '/standing' do
  erb :'user/users_standing'
end

get '/profile' do
  erb :'user/profile'
end
