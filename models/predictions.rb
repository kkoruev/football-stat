module DBModels
  class Prediction
    include DataMapper::Resource

    storage_names[:default] = 'predictions'

    property :id,             Serial
    property :home_score,     Integer
    property :away_score,     Integer
    property :done,           Boolean, :default => false

    def self.predictions_by_user(id)
      all(:user_id => id, done => false)
    end
  end
end
