require_relative '../../models/user'

class UserDeserializer

  def initialize(user_json)
    @user_json = user_json
  end

  def registration_data
    user = DBModels::User.new
    user.email = @user_json["email"]
    user.nickname = @user_json["nickname"]
    user
  end
end