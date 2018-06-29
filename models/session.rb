module DBModels
  class Session
    include DataMapper::Resource

    storage_names[:default] = 'sessions'

    property :id,             Serial
    property :user,           String, :required => true, :unique => true
    property :token,          String, :required => true, :unique => true
    property :user_id,        Integer, :required => true, :unique => true

    def user_session(user_email)
      DBModels::Session.first(:user => user_email)
    end

    def session(token)
      DBModels::Session.first(:token => token)
    end

    def generate_token(user_email, user_id)
      self.token = SecureRandom.hex(16)
      self.user = user_email
      self.user_id = user_id
      self.save
      self.token
    end

    def update_token
      token = SecureRandom.hex(16)
      self.update(:token => token)
      token
    end

    def remove_token(user_email)

    end

    def expired?(token)
      DBModels::Session.first(:token => token).nil?
    end
  end
end
