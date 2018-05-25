module ErrorMessages

  def user_exist(email)
    "#{email} is used by another user. Please enter other email"
  end

  def user_not_saved(user)
    "Could not save user"
  end

  def match_not_saved(match)
    "Could not save match #{MatchesSerializer.new.match_for_prediction(match)}"
  end
end
