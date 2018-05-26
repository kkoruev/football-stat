module Team
  # From json to team object deserializer
  class TeamSerializer

    def team_json(team)
      team = {:name => team.name}
      JSON.generate(team)
    end

    def teams_json(teams)
      array_of_teams = Array.new
      teams.map do |team|
        array_of_teams.push(team_json(team))
      end
      JSON.generate(array_of_teams)
    end
  end
end
