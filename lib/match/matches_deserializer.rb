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

    # private_class_method :new
    #
    # def MatchesDeserializer.single_match(single_match_json)
    # end
    #
    # def MatchesDeserializer.multiple_matches(multiple_matches_json)
    # end

  end
end
