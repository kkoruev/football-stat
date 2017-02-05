module Util
  class Prediction
    def self.matches_for_prediction(id)
      predictions = DBModels::Prediction.predictions_by_user(id)
      return predictions unless predictions.empty?
      return DBModels::Match.current
    end

    def self.add_predicted_matches(matches)
      Prediction.match_object(matches)
    end

    private

    def self.match_object(matches)
      len = matches.keys.length / 2
      keys = matches.keys
      all_predictions = []
      len.times do
        home = keys.shift
        away = keys.shift
        id = home[0].to_i
        home_score = matches[home]
        away_score = matches[away]
      end
    end
  end
end
