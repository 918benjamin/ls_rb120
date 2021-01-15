=begin
Using the class definition from step #3, let's create a few more people --
that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the same name,
how can we compare the two objects?


=end

### My code from ex3
class Person
  attr_reader :name, :first_name, :last_name

  def initialize(name)
    update_name(name)
  end

  def first_name=(name)
    self.name = "#{name} #{last_name}"
  end

  def last_name=(name)
    self.name = "#{first_name} #{name}"
  end
  
  def name=(name)
    update_name(name)
  end

  def update_name(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
    @name = "#{@first_name} #{@last_name}".strip
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts "Are bob and rob the same object?"
puts bob == rob

puts "Do bob and rob contain the same name?"
puts bob.name == rob.name

### My theory on why this works
# I'm guessing that other classes define their own == method and since we're
# dealing with two instances of the String class on line 49, the String class'
# == method is what is invoked.