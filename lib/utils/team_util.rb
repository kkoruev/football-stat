module Util
  class Team
    def self.all_teams
      DBModels::Team.all
    end

    def self.all_team_names
      teams = Team.all_teams
      array_teams = []
      teams.each do |team|
        array_teams.push(team.name)
      end
      array_teams
    end

    def self.add_team(name)
      team = DBModels::Team.new
      team.name = name
      team.save
    end

    def self.delete_team(name)
      team = DBModels::Team.first(:name => name)
      team.destroy unless team.nil?
    end
  end
end
