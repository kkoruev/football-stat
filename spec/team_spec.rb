require_relative '../config/database_test'
require_relative '../config/environment_test'
require_relative '../lib/utils/team_util'
require_relative '../models/team'


describe Util::Team do

  before :all do
    @first_test_name = "Manchster United"
    @second_test_name = "Chelsea"
    Util::Team.add_team(@first_test_name)
    Util::Team.add_team(@second_test_name)
  end
  
  describe '#add_team' do
    it "checks if all the new teams are added" do
        expect(Util::Team.all_teams.size).to eq(2)
    end
  end

  describe '#delete_team' do
    it "checks if a team was deletd" do
        Util::Team.delete_team(@first_test_name)
        expect(Util::Team.all_teams.size).to eq(1)
    end
  end
end