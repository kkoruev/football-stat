require_relative '../lib/user/register'
require_relative '../lib/utils/prediction_util'

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
  user = User::Register.login(params[:email], params[:password])
  cookies[:id] = user.id
  true
end

get '/standing' do
  erb :'user/users_standing'
end

get '/profile' do
  erb :'user/profile'
end

get '/predictions' do
  return 0 if cookies.empty?
  erb :'user/predict_matches', :locals => {
    :matches => Util::Prediction.matches_for_prediction(cookies[:id])
  }
end

post '/predictions' do
  return 0  if cookies.empty?
  Util::Prediction.add_predicted_matches(params, cookies[:id])
end
