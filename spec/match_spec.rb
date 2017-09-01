require_relative '../config/database_test'
require_relative '../config/environment_test'
require_relative '../lib/utils/match_util'
require_relative '../models/match'


describe Util::Match do
  
  describe '#add_match' do
    it "check if current matches is updated after new match is added" do
        Util::Match.add_match("Chelsea", "Arsenal", "21-12-2017", "3")
        expect(Util::Match.current_matches.size).to eq(1)
    end
  end

end