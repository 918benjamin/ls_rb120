=begin
Which of these two classes has an instance variable and how do you know?
Pizza class has an instance variable @name.
We know because the @ character designates an instance variable and because
the @name variable is initialized within an instance method.


LS Solution:
Can use the #instance_variables method to see an array of the instance variables
that an object has.
=end

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

pepperoni = Pizza.new("pepperoni")
apple = Fruit.new("Apple")

p pepperoni.instance_variables
p apple.instance_variables