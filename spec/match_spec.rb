require_relative '../config/database_test'
require_relative '../config/environment_test'
require_relative '../models/match'


describe DBModels::Match do

  describe '#add_match' do
    it "check if current matches is updated after new match is added" do
      match = DBModels::Match.new
      match.home_team = "Arsenal"
      match.save
    end
  end

end
