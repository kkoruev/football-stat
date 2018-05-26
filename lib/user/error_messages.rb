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
end
