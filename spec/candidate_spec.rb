require 'spec_helper'

RSpec.describe Candidate do
  before(:each) do
    @diana = Candidate.new({name: "Diana D", party: :democrat})
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@diana).to be_a Candidate
    end

    it 'has attributes' do 
      expect(@diana.name).to eq('Diana D')
      expect(@diana.party).to eq(:democrat)
      expect(@diana.votes).to eq(0)
    end
  end

  describe 'voting' do 
    it '#vote_for!' do 
      @diana.vote_for! 
      @diana.vote_for! 
      @diana.vote_for! 
      expect(@diana.votes).to eq(3)
      @diana.vote_for! 
      expect(@diana.votes).to eq(4)
    end
  end
end