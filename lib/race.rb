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

  def winner
    if open?
      false
    else 
      win_folks[0]
    end
  end

  def tie?
    win_folks.length > 1
  end

  def win_folks 
    win_person = @candidates.max_by do |candidate| 
      candidate.votes
    end
    all_win_people = @candidates.select do |candidate|
      candidate.votes == win_person.votes
    end
    all_win_people
  end
end