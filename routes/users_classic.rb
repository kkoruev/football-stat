# require_relative '../lib/user/register'
# require_relative '../lib/utils/prediction_util'
# require_relative '../lib/utils/user_util'
# require_relative '../lib/utils/team_util'


# get '/' do
#   redirect '/home'
# end

# get '/error' do
#   erb :'user/error'
# end

# get '/home' do
#   redirect '/login' unless User::Register.user_or_admin_logged?(cookies) 
#   return erb :'user/home' if cookies[:role].to_i == 0
#   erb :'admin/home' if cookies[:role].to_i == 1
# end

# get '/register' do
#   erb :'user/register'
# end

# post '/register' do
#   User::Register.register(params[:full_name], params[:email], params[:password])
#   #TO DO:
# end

# get '/login' do
#   redirect '/home' if User::Register.user_or_admin_logged?(cookies)
#   erb :'user/login'
# end

# get '/logout' do
#   cookies[:id] = ""
#   cookies[:role] = ""
#   redirect '/home'
# end

# post '/login' do
#   user = User::Register.login(params[:email], params[:password])
#   redirect '/error' if user.nil?
#   p user
#   cookies[:id] = user.id
#   cookies[:role] = user.role
#   redirect '/home'
# end

# get '/standing' do
#   redirect '/login' unless User::Register.user_logged?(cookies)
#   erb :'user/users_standing', :locals => {
#     :standing => Util::Prediction.standing
#   }
# end

# get '/profile' do
#   redirect '/login' unless User::Register.user_logged?(cookies)
#   profile = Util::User.current_user_as_hash(cookies[:id])
#   team_names = Util::Team.all_team_names
#   team_names.unshift(profile[:fav_team]) unless profile[:fav_team].nil?
#   erb :'user/profile', :locals => {
#     :team_names => team_names,
#     :profile => Util::User.current_user_as_hash(cookies[:id])
#   }
# end

# post '/edit/profile' do
#   Util::User.update_user_mail(cookies[:id], params[:email])
#   Util::User.update_user_name(cookies[:id], params[:full_name])
#   Util::User.update_user_favourite_name(cookies[:id], params[:team])
#   redirect '/profile'
# end


# get '/predictions' do
#   redirect '/login' unless User::Register.user_logged?(cookies)
#   erb :'user/predict_matches', :locals => {
#     :matches => Util::Prediction.matches_for_prediction(cookies[:id])
#   }
# end

# post '/predictions' do
#   redirect '/login' unless User::Register.user_logged?(cookies)
#   Util::Prediction.add_predicted_matches(params, cookies[:id])
# end