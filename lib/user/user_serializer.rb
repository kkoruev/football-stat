class UserSerializer
  def session_token(token)
    map = {:token => token}
    JSON.generate(map)
  end
end
