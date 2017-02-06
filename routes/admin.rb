require_relative '../lib/utils/team_util'
require_relative '../lib/utils/match_util'
require_relative '../lib/utils/prediction_util'

get '/teams' do
  @teams = Util::Team.all_teams
  erb :'admin/edit_teams'
end

get '/matches' do
  erb :'admin/add_matches'
end

post '/matches' do
  @number_of_matches = params["number"]
  @team_names = []
  Util::Team.all_teams.each do |team|
    @team_names.push(team.name)
  end
  erb :'admin/submit_new_matches'
end

post '/matches/submit' do
  len = (params.keys.length / 2) - 1
  len.times do |count|
    key_h = "home" + count.to_s
    key_a = "away" + count.to_s
    home_t = params[key_h]
    away_t = params[key_a]
    gameweek = params["gameweek"]
    date = params["date"]
    return false unless Util::Match.add_match(home_t, away_t, date, gameweek.to_i)
  end
  return true
end

get '/results/update' do
  @current_matches = Util::Match.current_matches
  erb :'admin/update_results'
end

post '/results/update' do
  Util::Prediction.add_results(params)
  true
end

post '/teams/:name' do |name|
  Util::Team.add_team(name)
end

delete '/teams/:name' do |name|
  Util::Team.delete_team(name)
end
