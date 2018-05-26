module Team
  # From json to team object deserializer
  class TeamDeserializer
    def team(team_json)
      team = DBModels::Team.new
      team.name = @team_json['name']
      team
    end
  end
end
