module UserErrorMessages
  
  def user_exist(email)
    "#{email} is used by another user. Please enter other email"
  end

  def user_not_saved(user)
    "Could not save user"
  end
end