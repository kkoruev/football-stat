require_relative '../lib/match/result'


describe Match::Result do

  describe '#empty' do
    it "is empty when not initialized correctly" do
        expect(::Match::Result.new(1, "").empty?).to be true
    end
  end


end

