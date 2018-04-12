# From json to team object deserializer
class TeamDeserializer
  def initialize(team_json)
    @team_json = team_json
  end

  def team_data
    team = DBModels::Team.new
    team.name = @team_json['name']
    team
  end
end
