class Race
  attr_reader :name
  
  def initialize(name)
    @name = name
    @candidates = []
  end
end