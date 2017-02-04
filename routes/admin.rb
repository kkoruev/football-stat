require_relative '../lib/utils/team_util'

get '/teams' do
  @teams = Util::Team.all_teams
  erb :'admin/edit_teams'
end

post '/teams/:name' do |name|
  Util::Team.add_team(name)
end

delete '/teams/:name' do |name|
  Util::Team.delete_team(name)
end
