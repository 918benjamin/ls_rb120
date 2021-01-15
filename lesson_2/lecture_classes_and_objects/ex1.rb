# Given the below usage of the Person class, code the class definition.

# Solution (Person class definition)
class Person
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

end





# Given usage of Person class
bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'

