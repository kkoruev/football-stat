module DBModels
  class Match
    include DataMapper::Resource

    storage_names[:default] = 'matches'

    property :id,             Serial
    property :home_team,      Integer
    property :away_team,      Integer
    property :home_score,     Integer
    property :away_score,     Integer
    property :date,           Date
  end
end
