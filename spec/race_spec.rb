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

  describe 'race openness' do 
    it '#open?' do 
      expect(@race.open?).to be true
    end

    it '#close!' do 
      @race.close!
      expect(@race.open?).to be false
    end
  end

  describe '#winner' do 
    it 'no winner if race is open' do 
      expect(@race.winner).to be false
    end

    it 'candidate with most votes if closed' do 
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate1.vote_for!
      candidate1.vote_for!
      candidate2.vote_for!
      @race.close!
      expect(@race.winner).to eq(candidate1)
    end

    it 'if tie multiple most voted candidates' do 
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate3 = @race.register_candidate!({name: 'Sylvester S', party: :libertarian})
      candidate1.vote_for!
      candidate1.vote_for!
      candidate2.vote_for!
      candidate2.vote_for!
      candidate3.vote_for!
      @race.close!
      expect(@race.winner).to eq(candidate1)
    end
  end
  
  describe 'helpers' do 
    it '#win_folks' do 
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate3 = @race.register_candidate!({name: 'Sylvester S', party: :libertarian})
      candidate1.vote_for!
      candidate1.vote_for!
      candidate2.vote_for!
      candidate2.vote_for!
      candidate3.vote_for!
      expect(@race.win_folks).to eq([candidate1, candidate2])
    end
  end
end