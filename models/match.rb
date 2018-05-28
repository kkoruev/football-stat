module DBModels
  class Match
    include DataMapper::Resource

    storage_names[:default] = 'matches'

    property :id,             Serial
    property :home_team,      String
    property :away_team,      String
    property :home_score,     Integer
    property :away_score,     Integer
    property :date,           Date
    property :gameweek,       Integer

    has n, :predictions

    def current
      DBModels::Match.all(:home_score => nil)
    end

    def matches_from_gameweek(gameweek)
      DBModels::Match.all(:gameweek => gameweek)
    end
  end
end
