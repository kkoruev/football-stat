module DBModels
  class Prediction
    include DataMapper::Resource

    storage_names[:default] = 'predictions'

    property :id,             Serial
    property :home_score,     Integer, :required => true
    property :away_score,     Integer, :required => true
    property :done,           Boolean, :default => false

    def self.predictions_by_user(id)
      all(:user_id => id, done => false)
    end

    def matches_by_id(match_id)
      DBModels.Predictions.all(:match_id => match_id)
    end

    def calculate_points(result)
      #compare results and get the points
      #update_user_points
      #update_matches
    end
  end
end
