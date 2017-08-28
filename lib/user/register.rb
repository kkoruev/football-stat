require_relative '../utils/password_util'

module User
  class Register
    def self.register(full_name, email, password, is_admin = 0)
      user = Register.make_user(full_name, email, password, is_admin)
      existing_user = Register.user_with_email(email)
      return existing_user if existing_user.nil?
      user.save
    end

    def self.login(email, password)
      user = Register.user_with_email(email)
      return nil if user.nil?
      hashed_password = Util::Password.hashed_password(password, user.salt)
      return user if user.hashed_pass == hashed_password
      return nil
    end



    private

    def self.make_user(full_name, email, password, is_admin)
      salt = Util::Password.generate_salt
      hashed_password = Util::Password.hashed_password(password, salt)
      user = DBModels::User.new
      user.full_name = full_name
      user.email = email
      user.salt = salt
      user.hashed_pass = hashed_password
      user.role = is_admin
      user
    end

    def self.user_with_email(email)
      return DBModels::User.first(:email => email)
    end
  end
end
