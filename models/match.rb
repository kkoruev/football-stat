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
  end
end
