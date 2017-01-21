require 'securerandom'
require 'digest'

module PasswordUtil
  def self.generate_salt
    SecureRandom.hex(16)
  end

  def self.hashed_password(password, salt)
    password = password + salt
    Digest::SHA256.base64digest(password)
  end
end
