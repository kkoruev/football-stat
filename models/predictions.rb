module DBModels
  class Prediction
    include DataMapper::Resource

    storage_names[:default] = 'predictions'

    property :id,             Serial
    property :home_score,     Integer, :required => true
    property :away_score,     Integer, :required => true
    property :done,           Boolean, :default => false

    def current_predictions_by_user(id)
      DBModels::Prediction.all(:user_id => id, :done => false)
    end

    def matches_by_id(match_id)
      DBModels::Prediction.all(:match_id => match_id, :done => false)
    end

    def predicted_matches(user_id)
      DBModels::Prediction.all(:user_id => user_id, :done => false)
    end

    def calculate_points(result)
      points = check_prediction(result)
      update_user_points(points)
      self.update(:done => true)
    end

    private

    def update_user_points(points)
      user = DBModels::User.new.user(self.user_id)
      return if user.nil?
      user.update_points(points)
    end

    def check_prediction(result)
      prediction_result = convert_to_result
      result.compare(prediction_result)
    end

    def convert_to_result
      ::Match::Result.new(self.home_score, self.away_score)
    end
  end
end
