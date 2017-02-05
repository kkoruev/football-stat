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
      parsed_matches = Prediction.parse_matches(matches)
      p parsed_matches
      Prediction.save_predictions(parsed_matches, id)
    end

    def self.add_results(matches)
      parse_matches = Prediction.parse_matches(matches)
      #get match id
      #get_result
      #function(match_id, result)
    end

    private

    def self.parse_matches(matches)
      len = matches.keys.length / 2
      keys = matches.keys
      parsed_matches = {}
      len.times do
        home = keys.shift
        away = keys.shift
        id = home[0].to_i
        parsed_matches[id] = [matches[home], matches[away]]
      end
      parsed_matches
    end

    def self.save_predictions(matches, user_id)
      user = DBModels::User.get(user_id)
      matches.keys.each do |id|
        match = DBModels::Match.get(id)
        home = matches[id].first
        away = matches[id].last
        prediction = Prediction.prediction_object(home, away, id, user_id)
        match.predictions.push(prediction)
        user.predictions.push(prediction)
        match.save
        user.save
      end
      true
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
