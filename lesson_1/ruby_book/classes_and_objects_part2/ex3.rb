# When running the following code...
# Original
# class Person
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"

# We get the following error...
# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how do we fix it?
# We get this error because with `attr_reader :name` on line 2 (original, line
# 4 above) we have only defined a getter method for the @name instance variable
# and on line 9 (original, line 11 above) we are trying to use a setter method
# `name=` that doesn't exist.

# Fixed
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"