require 'spec_helper'

RSpec.describe Election do
  before(:each) do
    @election = Election.new('2023')
    @race_1 = Race.new('Texas Governor')
    @race_2 = Race.new('Colorado Governor')
    @candidate1_tx = @race_1.register_candidate!({name: 'Diana D', party: :democrat})
    @candidate2_tx = @race_1.register_candidate!({name: 'Roberto R', party: :republican})
    @candidate1_co = @race_2.register_candidate!({name: 'Sylvester S', party: :democrat})
    @candidate2_co = @race_2.register_candidate!({name: 'John Jacob Jingleheimer Schmidt', party: :republican})
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@election).to be_a Election
    end

    it 'has attributes' do 
      expect(@election.year).to eq('2023')
      expect(@election.races).to eq([])
    end
  end

  describe '#add_race' do 
    it '#add_race' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      expect(@election.races).to eq([@race_1, @race_2])
    end
  end

  describe 'election candidates' do 
    it '#candidates' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      expect(@election.candidates).to eq([@candidate1_tx, @candidate2_tx, @candidate1_co, @candidate2_co])
    end
  end

  describe 'election counts votes by candidate' do 
    it '#vote_counts' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      @candidate1_tx.vote_for!
      @candidate1_tx.vote_for!
      @candidate2_tx.vote_for!
      @candidate1_co.vote_for!
      @candidate2_co.vote_for!
      @candidate2_co.vote_for!
      expect(@election.vote_counts).to eq({
        'Diana D' => 2,
        'Roberto R' => 1,
        'Sylvester S' => 1,
        'John Jacob Jingleheimer Schmidt' => 2
      })
    end
  end

  describe '#winners' do 
    it 'winners for election can be returned' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      @candidate1_tx.vote_for!
      @candidate1_tx.vote_for!
      @candidate1_tx.vote_for!
      @candidate2_tx.vote_for!
      @candidate1_co.vote_for!
      @candidate1_co.vote_for!
      @candidate1_co.vote_for!
      @candidate2_co.vote_for!
      @candidate2_co.vote_for!
      @race_1.close!
      @race_2.close!
      expect(@election.winners).to eq([@candidate1_tx, @candidate1_co])
    end
    
    it 'no winners are returned for a race if tied' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      @candidate1_tx.vote_for!
      @candidate2_tx.vote_for!
      @candidate1_co.vote_for!
      @candidate1_co.vote_for!
      @candidate2_co.vote_for!
      @race_1.close!
      @race_2.close!
      expect(@election.winners).to eq([@candidate1_co])
    end

    it 'no winners are returned for a race if not closed' do 
      @election.add_race(@race_1)
      @election.add_race(@race_2)
      @candidate1_tx.vote_for!
      @candidate1_tx.vote_for!
      @candidate2_tx.vote_for!
      @candidate1_co.vote_for!
      @candidate1_co.vote_for!
      @candidate2_co.vote_for!
      @race_1.close!
      expect(@election.winners).to eq([@candidate1_tx])
    end
  end
end