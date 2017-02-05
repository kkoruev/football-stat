module DBModels
  class User
    include DataMapper::Resource

    storage_names[:default] = 'users'

    property :id,             Serial
    property :full_name,      String
    property :email,          String
    property :fav_team,       String
    property :hashed_pass,    String
    property :salt,           String
    property :position_table, String

    has n, :predictions
  end
end
