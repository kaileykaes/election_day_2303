require 'spec_helper'

RSpec.describe Race do
  before(:each) do
    @race = Race.new("Texas Governor")
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@race).to be_a Race
    end

    it 'has attributes' do 
      expect(@race.office).to eq('Texas Governor')
      expect(@race.candidates).to eq([])
    end
  end

  describe 'candidate registration' do 
    it '#register_candidate!' do 
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      expect(candidate1.class).to eq(Candidate)
      expect(candidate1.name).to eq('Diana D')
      expect(candidate1.party).to eq(:democrat)
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      expect(@race.candidates).to eq([candidate1, candidate2])
    end
  end
end