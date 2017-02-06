require_relative '../match/result'

module Util
  class Prediction
    def self.matches_for_prediction(id)
      predictions = DBModels::Prediction.predictions_by_user(id)
      p predictions
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
      Prediction.save_predictions(parsed_matches, id)
    end

    def self.add_results(matches)
      parsed_matches = Prediction.parse_matches(matches)
      results = Prediction.construct_result_hash(parsed_matches)
      update_points(results)
      update_matches(results)
    end

    private

    def self.update_matches(results)
      results.keys.each do |key|
        match = DBModels::Match.get(key)
        match.home_score = results[key].home_team
        match.away_score = results[key].away_team
        match.save
      end
    end

    def self.update_points(results)
      results.keys.each do |id|
        update_points_for_match(id, results[id])
      end
    end

    def self.update_points_for_match(id, final_result)
      all_predictions = DBModels::Prediction.all(:match_id => id)
      all_predictions.each do |prediciton|
        result = ::Match::Result.new(prediciton.home_score, prediciton.away_score)
        update_points_for_user(prediciton.user_id, result, final_result)
        prediciton.done = true
        prediciton.save
      end
    end

    def self.update_points_for_user(id, user_result, final_result)
      return true if user_result.empty?
      points = final_result.compare(user_result)
      return true if points == 0
      user = DBModels::User.get(id)
      user.points = points + user.points
      user.save
    end

    def self.construct_result_hash(matches)
      hash_result = {}
      matches.keys.each do |key|
        result = ::Match::Result.new(matches[key].first, matches[key].last)
        hash_result[key] = result unless result.empty?
      end
      hash_result
    end

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
