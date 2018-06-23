module Match
  class MatchesSerializer
    def match_for_prediction(match)
      match_for_prediction = prediction_hash(match)
      JSON.generate(match_for_prediction)
    end

    # TODO: Change implementation
    def matches_for_prediction(matches)
      matches_array = []
      matches.map do |match|
        matches_array.push(prediction_hash(match))
      end
      JSON.generate(matches_array)
    end


    def predictions(predictions)
      json_predictions = []
      predictions.map do |prediction|
        match = DBModels::Match.new.match_by_id(prediction.match_id)
        next if match.nil?
        json_prediction = { :home_team => match.home_team,
                            :home_score => prediction.home_score,
                            :away_team => match.away_team,
                            :away_score => prediction.away_score,
                            :gameweek => match.gameweek }
        json_predictions.push(json_prediction)
      end
      JSON.generate(json_predictions)
    end

    private

    ## TODO: Change name and impl
    def prediction_hash(match)
      match_for_prediction = {:id => match.id,
                              :home_team => match.home_team,
                              :away_team => match.away_team,
                              :date => match.date,
                              :gameweek => match.gameweek}
      match_for_prediction
    end
  end
end
