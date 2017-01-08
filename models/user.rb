class User
  include DataMapper::Resource

  property :id,             Serial
  property :full_name,      String
  property :email,          String
  property :fav_team,       String
  property :hashed_pass,    String
end

DataMapper.auto_upgrade!
