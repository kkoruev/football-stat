require_relative '../utils/password_util'

class UserDeserializer

  def initialize(user_json)
    @user_json = user_json
  end

  def registration_data
    salt = Util::Password.generate_salt
    password = @user_json["password"]
    user = DBModels::User.new
    user.email = @user_json["email"]
    user.nickname = @user_json["nickname"]
    user.salt = salt
    user.hashed_pass = Util::Password.hashed_password(password, salt)
    user
  end

  def login_data
    user = DBModels::User.new
    user.email = @user_json["email"]
    user
  end
end
