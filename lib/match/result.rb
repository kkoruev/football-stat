module Match
  class Result

    attr_accessor :home_score, :away_score

    def initialize(home, away)
      @home_score = home.to_s
      @away_score = away.to_s
    end

    def empty?
      return true if @home_score.empty? or @away_score.empty?
      return false
    end

    def compare(result)
      return 0 if empty?
      return 0 if result.empty?
      return 3 if full_win(result)
      return 1 if half_win(result)
      return 0
    end

    private

    def full_win(result)
      return @home_score == result.home_score && @away_score == result.away_score
    end

    def half_win(result)
      current = @home_score.to_i <=> @away_score.to_i
      other = result.home_score.to_i <=> result.away_score.to_i
      return current == other
    end
  end
end
