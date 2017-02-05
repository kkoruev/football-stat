module Util
  class Prediction
    def self.matches_for_prediction(id)
      predictions = DBModels::Prediction.predictions_by_user(id)
      matches = []
      predictions.each do |prediction|
        match = DBModels::Match.get(prediction.match_id)
        matches.push(match)
      end
      return matches unless predictions.empty?
      return DBModels::Match.current
    end

    def self.add_predicted_matches(matches, id)
      Prediction.save_predictions(matches, id)
    end

    private

    def self.save_predictions(matches, user_id)
      len = matches.keys.length / 2
      keys = matches.keys
      user = DBModels::User.get(user_id)
      len.times do
        home = keys.shift
        away = keys.shift
        id = home[0].to_i
        match = DBModels::Match.get(id)
        prediction = Prediction.prediction_object(matches[home], matches[away], id, user_id)
        match.predictions.push(prediction)
        user.predictions.push(prediction)
        match.save
        user.save
      end
    end

    def self.prediction_object(home, away, id, user_id)
      prediction = DBModels::Prediction.first(:match_id => id, :user_id => user_id)
      prediction = DBModels::Prediction.new if prediction.nil?
      if home.empty? or away.empty?
        prediction.home_score = nil
        prediction.away_score = nil
      else
        prediction.home_score = home.to_i
        prediction.away_score = away.to_i
      end
      prediction
    end
  end
end
