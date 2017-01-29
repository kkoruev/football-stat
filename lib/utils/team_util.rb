module Util
  class Team
    def self.all_teams
      DBModels::Team.all
    end
  end
end
