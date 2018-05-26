module Match
  class MatchesSerializer

    def match_for_prediction(match)
      match_for_prediction = {:home_team => match.home_team,
                              :away_team => match.away_team,
                              :date => match.date,
                              :gameweek => match.gameweek}
      match_for_prediction
    end

    def matches_for_prediction(matches)
      matches_array = Array.new

      matches.map do |match|
        p match
        matches_array.push(match_for_prediction(match))
      end
      JSON.generate(matches_array)
    end
  end
end
