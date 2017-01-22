require_relative '../lib/user/register'

get '/home' do
  erb :'shared/home'
end

get '/register' do
  erb :'user/register'
end

post '/register' do
  User::Register.register("Kris Koruev", "k.koruev@abv,bg", "kris1")
end

get '/login' do
  erb :'user/login'
end

get '/standing' do
  erb :'user/users_standing'
end

get '/profile' do
  erb :'user/profile'
end
