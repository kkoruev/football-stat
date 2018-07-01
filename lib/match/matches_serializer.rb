module Match
  class MatchesSerializer
    def match_for_prediction(match)
      match_for_prediction = prediction_hash(match)
      JSON.generate(match_for_prediction)
    end

    # TODO: Change implementation
    def matches_for_prediction(matches)
      matches_array = matches.map do |match|
        prediction_hash(match)
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

    def statistics(predictions)
      win1 = 0
      win2 = 0
      drawX = 0
      predictions.each do |predictions_for_one|
        predictions_for_one.each do |prediction|
          win1+=1 if prediction.home_score > prediction.away_score
          win2+=1 if prediction.home_score < prediction.away_score
          drawX+=1 if prediction.home_score == prediction.away_score
        end
      end
      json_statistic = {
        :win1 => win1,
        :win2 => win2,
        :drawX => drawX
      }
      JSON.generate(json_statistic)
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
