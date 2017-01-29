require_relative '../lib/utils/team_util'

get '/teams' do
  @teams = Util::Team.all_teams
  erb :'admin/edit_teams'
end

post '/teams' do
  p params
  p "Here"
end
