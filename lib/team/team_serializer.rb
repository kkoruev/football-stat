module Team
  # From json to team object deserializer
  class TeamSerializer
    def team_json(team)
      team = to_h(team)
      JSON.generate(team)
    end

    def teams_json(teams)
      array_of_teams = Array.new
      teams.map do |team|
        array_of_teams.push(to_h(team))
      end
      JSON.generate(array_of_teams)
    end

    private

    def to_h(team)
      team = {:name => team.name}
    end
  end
end
