require_relative '../utils/password_util'

module User
  class Register
    def self.register(full_name, email, password)
      salt = PasswordUtil.salt
      hashed_password = PasswordUtil.hashed_password(password, salt)
    end
  end
end
