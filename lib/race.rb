class Race
  attr_reader :office, 
              :candidates, 
              :openness
  
  def initialize(office)
    @office = office
    @candidates = []
    @openness = true
  end

  def register_candidate!(candidate)
    @candidates << new_candidate = Candidate.new({
      name: candidate[:name],
      party: candidate[:party]
    })
    new_candidate
  end

  def open?
    @openness
  end

  def close!
    @openness = false
  end
end