module Match
  class MatchesDeserializer
    def matches_for_predicting(matches_json)
      matches_for_predicting = Array.new

      matches_json.map do |match|
        model = DBModels::Match.new
        model.home_team = match['home_team']
        model.away_team = match['away_team']
        model.date = match['date']
        model.gameweek = match['gameweek']
        matches_for_predicting.push(model)
      end
      matches_for_predicting
    end

    def prediction(prediction_json)
      model = DBModels::Prediction.new
      model.home_score = prediction_json['home_score']
      model.away_score = prediction_json['away_score']
      model.match_id = prediction_json['match_id']
      model.user_id = prediction_json['user_id']
      model
    end

    # private_class_method :new
    #
    # def MatchesDeserializer.single_match(single_match_json)
    # end
    #
    # def MatchesDeserializer.multiple_matches(multiple_matches_json)
    # end

  end
end
