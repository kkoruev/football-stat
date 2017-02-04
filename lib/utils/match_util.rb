module Util
  class Match
    def self.add_match(home, away, date, gameweek)
      match = DBModels::Match.new
      match.home_team = home
      match.away_team = away
      match.date = date
      match.gameweek = gameweek
      match.save
    end
  end
end
