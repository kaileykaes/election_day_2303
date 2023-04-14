class Election
  attr_reader :year, 
              :races
  
  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    @races << race
  end

  def candidates
    candidates = @races.flat_map do |race|
      race.candidates.find_all do |candidate|
        candidate
      end
    end
    candidates
  end

  def vote_counts 
    votes_by_candidate = Hash.new(0)
    candidates.map do |candidate|
      votes_by_candidate[candidate.name] += candidate.votes 
    end
    votes_by_candidate
  end
end