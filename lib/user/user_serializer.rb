class UserSerializer
  def session_token(token)
    map = {:token => token}
    JSON.generate(map)
  end

  def standing(users)
    json_users = []
    users.map do |user|
      json_user = {
        :email => user.email,
        :points => user.points
      }
      json_users.push(json_user)
    end
    JSON.generate(json_users)
  end
end
