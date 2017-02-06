module Match
  class Result

    attr_accessor :home_team, :away_team

    def initialize(home, away)
      @home_team = home.to_s
      @away_team = away.to_s
    end

    def empty?
      return true if @home_team.empty? or @away_team.empty?
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
      return @home_team == result.home_team && @away_team == result.away_team
    end

    def half_win(result)
      current = @home_team.to_i <=> @away_team.to_i
      other = result.home_team.to_i <=> result.away_team.to_i
      return current == other
    end
  end
end

