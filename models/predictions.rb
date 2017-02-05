module DBModels
  class Prediction
    include DataMapper::Resource

    storage_names[:default] = 'predictions'

    property :id,             Serial
    property :home_score,     Integer
    property :away_score,     Integer

    def self.predictions_by_user(id)
      all(:user_id => id)
    end
  end
end
