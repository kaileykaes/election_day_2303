class Race
  attr_reader :office, 
              :candidates
  
  def initialize(office)
    @office = office
    @candidates = []
  end

  def register_candidate!(candidate)
    @candidates << new_candidate = Candidate.new({
      name: candidate[:name],
      party: candidate[:party]
    })
    new_candidate
  end
end