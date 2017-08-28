require_relative '../lib/user/register'
require_relative '../lib/utils/prediction_util'

get '/' do
  redirect '/home' unless cookies[:id].nil? or cookies[:id].empty?
  redirect '/login'
end

get '/error' do
  erb :'user/error'
end

get '/home' do
  redirect '/login' if cookies[:id].nil? or cookies[:id].empty?
  return erb :'user/home' if cookies[:role].to_i == 0
  erb :'admin/home' if cookies[:role].to_i == 1
end

get '/register' do
  erb :'user/register'
end

post '/register' do
  User::Register.register(params[:full_name], params[:email], params[:password])
  #TO DO:
end

get '/login' do
  redirect '/home' unless cookies[:id].nil? or cookies[:id].empty?
  erb :'user/login'
end

get '/logout' do
  cookies[:id] = nil
  cookies[:role] = nil
  redirect '/home'
end

post '/login' do
  user = User::Register.login(params[:email], params[:password])
  redirect '/error' if user.nil?
  p user
  cookies[:id] = user.id
  cookies[:role] = user.role
  redirect '/home'
end

get '/standing' do
  erb :'user/users_standing', :locals => {
    :standing => Util::Prediction.standing
  }
end

get '/profile' do
  erb :'user/profile'
end

get '/predictions' do
  redirect '/login' if cookies[:id].nil? or cookies[:id].empty?
  erb :'user/predict_matches', :locals => {
    :matches => Util::Prediction.matches_for_prediction(cookies[:id])
  }
end

post '/predictions' do
  redirect '/login' if cookies[:id].nil? or cookies[:id].empty?
  Util::Prediction.add_predicted_matches(params, cookies[:id])
end
