require_relative '../lib/utils/password_util'
require_relative '../lib/user/user_functions'

module DBModels
  class User
    include DataMapper::Resource
    include UserFunctions
    
    self.raise_on_save_failure = true
    storage_names[:default] = 'users'

    property :id,             Serial
    property :nickname,       String, :required => true
    property :email,          String, :required => true, :unique => true
      # :format => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    property :fav_team,       String
    property :hashed_pass,    String, :required => true
    property :salt,           String, :required => true
    property :position_table, String
    property :points,         Integer, :default => 0
    property :role,           Integer, :default => 0

    has n, :predictions

    def self.create_default_admin
      admin = DBModels::User.first(:email => 'admin@football_stat.com')
      return true unless admin.nil?
      salt = Util::Password.generate_salt
      hashed_password = Util::Password.hashed_password('admin', salt)
      DBModels::User.create(:full_name => 'admin', 
                            :email => 'admin@football_stat.com',
                            :hashed_pass => hashed_password,
                            :salt => salt)
    end

    def register(password)
      
    end
  end
end
