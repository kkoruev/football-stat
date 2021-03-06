module DBModels
  class User
    include DataMapper::Resource

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

    def users_standing
      DBModels::User.all(:order => [:points.desc])
    end

    def user(id)
      DBModels::User.first(:id => id)
    end

    def update_points(points)
      points = self.points + points
      self.update(:points => points)
    end

    def exists?
      DBModels::User.count(:email => self.email) > 0
    end

    def user_role_text
      return 'U' if role == 0
      return 'A' if role == 1
    end

    def admin?
      return self.role == 1
    end

    def create_default_admin
      admin = DBModels::User.first(:email => 'admin1@football_stat.com')
      return true unless admin.nil?
      salt = Util::Password.generate_salt
      hashed_password = Util::Password.hashed_password('admin', salt)
      DBModels::User.create(:nickname => 'admin',
                            :email => 'admin1@football_stat.com',
                            :hashed_pass => hashed_password,
                            :salt => salt,
                            :role => 1)
    end

    def authenticate(password)
      no_such_user = "User with specified email could not be found"
      wrong_password = "Incorrect password"
      raise LoginAuthenticationError.new(no_such_user) unless exists?
      user = DBModels::User.first(:email => email)
      hashed_pass_to_check = Util::Password.hashed_password(password, user.salt)
      password_match = (user.hashed_pass == hashed_pass_to_check)
      raise LoginAuthenticationError.new(wrong_password) unless password_match
      user
    end

    def register(password)

    end
  end
end
