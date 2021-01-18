=begin
Class based inheritance works great when it's used to model hierarchical domains.
Let's take a look at a few practice problems. Suppose we're building a software
system for a pet hotel business, so our classes deal with pets.

Given the following class
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

One problem is that we need to keep track of different breeds of dogs, since
they have slightly different behaviors. For example, bulldogs can't swim, but
all other dogs can.

Create a sub-class from Dog called Bulldog overriding the swim method to return
"can't swim!"

=end

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

bully = Bulldog.new
puts bully.speak
puts bully.swim