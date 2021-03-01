class Human
  attr_accessor :name
  attr_reader :birth_year

  def initialize(name, birth_year)
    @name = name
    @birth_year = birth_year
  end
  
  def age
    Time.now.year - @birth_year
  end
end

me = Human.new("Ben", 1991)
puts me.name
puts me.birth_year
puts me.age
me.name = "Alberto"
me.birth_year = 2008 # raises an exception, exactly what we intend because we don't want to allow anything to change the @birth_year of a Human object
