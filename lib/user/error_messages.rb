module ErrorMessages

  def user_exist(email)
    "#{email} is used by another user. Please enter other email"
  end

  def user_not_saved(user)
    "Could not save user"
  end

  def match_not_saved(match)
    "Could not save match #{Match::MatchesSerializer.new.match_for_prediction(match)}"
  end

  def team_not_saved(team_name)
    "Could not save team with name = #{team_name}"
  end

  def no_such_gameweek(gameweek)
    "Could not find matches from gameweek = #{gameweek}"
  end

  def could_not_delete_matches(gameweek)
    "Could not delete matches from gameweek = #{gameweek}! Chek db conneciton."
  end

  def parse_error
    "Could not parse data. Check input parameters"
  end
end
