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

    def all_predictions_for_current
      all_predictions = []
      matches = self.current
      matches.each do |match|
        predictions = DBModels::Prediction.new.matches_by_id(match.id)
        all_predictions.push(predictions)
      end
      all_predictions
    end

    def current
      DBModels::Match.all(home_score: nil)
    end

    def matches_from_gameweek(gameweek)
      DBModels::Match.all(:gameweek => gameweek)
    end

    def match_by_id(match_id)
      DBModels::Match.first(:id => match_id)
    end

    def update_score(home_score, away_score)
      self.update(:home_score => home_score, :away_score => away_score)
    end
  end
end
