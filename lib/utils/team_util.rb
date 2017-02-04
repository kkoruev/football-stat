module Util
  class Team
    def self.all_teams
      DBModels::Team.all
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
