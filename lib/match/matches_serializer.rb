module Match
  class MatchesSerializer
    def match_for_prediction(match)
      match_for_prediction = prediction_hash(match)
      JSON.generate(match_for_prediction)
    end

    def matches_for_prediction(matches)
      matches_array = Array.new
      matches.map do |match|
        p match
        matches_array.push(prediction_hash(match))
      end
      JSON.generate(matches_array)
    end

    private

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
