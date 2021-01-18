=begin

Create a new class called Cat, which can do everything a dog can, except swim or
fetch. Assume the methods do the exact same thing. Hint: don't just copy and
paste all methods in Dog into Cat; try to come up with some class hierarchy.

=end

module Swimmable
  def swim
    'swimming!'
  end
end

module Fetchable
  def fetch
    'fetching!'
  end
end

class Mammal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Mammal
  include Swimmable
  include Fetchable

  def speak
    'bark!'
  end
end

class Cat < Mammal
  def speak
    'meow!'
  end
end

pete = Mammal.new
kitty = Cat.new
dave = Dog.new

puts pete.run
# puts pete.speak

puts kitty.run
puts kitty.speak
# puts kitty.fetch

puts dave.speak