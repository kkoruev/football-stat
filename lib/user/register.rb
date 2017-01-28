require_relative '../utils/password_util'

module User
  class Register
    def self.register(full_name, email, password)
      salt = PasswordUtil.generate_salt
      hashed_password = PasswordUtil.hashed_password(password, salt)
      user = DBModels::User.new
      user.full_name = full_name
      user.email = email
      user.salt = salt
      user.hashed_pass = hashed_password
      user.save
    end
  end
end
