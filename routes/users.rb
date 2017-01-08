get '/home' do
  erb :'shared/home'
end

get '/register' do
  erb :'user/register'
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
