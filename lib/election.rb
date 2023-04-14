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
end