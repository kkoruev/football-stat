require_relative '../config/database_test'
require_relative '../config/environment_test'
require_relative '../lib/user/register'
require_relative '../models/user'


describe User::Register do

  before :all do
    @email = "k.koruev@test.com"
    @password = "1234"
    User::Register.register("Kris", @email, @password)
  end
  
  describe '#register' do
    it "register user" do
      user = DBModels::User.all(:email => @email)
      expect(user).not_to be_empty
    end

    it "does not register again with same email" do
      User::Register.register("Kris", @email, @password)
      expect(DBModels::User.all.size).to eq(1)
    end
  end

  describe '#login' do
    it "does login with existing email" do
      expect(User::Register.login(@email, @password)).not_to be nil
    end

    it "does not login with wrong password" do
      expect(User::Register.login(@email, "22")).to be nil
    end
  end

end

