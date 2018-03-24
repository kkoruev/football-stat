module Config
  class Database
    def setup
      DataMapper.setup(:default, 'mysql://root:root@localhost:3306/football_stat')
    end
  end
end
