require_relative '../utils/password_util'
require 'dm-validations'

module DBModels
  class User
    include DataMapper::Resource

    self.raise_on_save_failure = true

    storage_names[:default] = 'users'

    property :id,             Serial
    property :full_name,      String, :required => true
    property :email,          String, :required => true, :unique => true,
      :format => :email_addres
    property :fav_team,       String
    property :hashed_pass,    String, :required => true
    property :salt,           String, :required => true
    property :position_table, String
    property :points,         Integer, :default => 0
    property :role,           Integer, :default => 0

    has n, :predictions

    def self.create_default_admin
      salt = Util::Password.generate_salt
      hashed_password = Util::Password('admin', salt)
      DBModels::User.create(:full_name => 'admin', 
                            :email_addres => 'admin@football_stat.com',
                            :hashed_pass=>  )
    end

  end
end
