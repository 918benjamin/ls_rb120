class Parent
  def say_hi
    p "Hi from Parent."
  end
end

# p Parent.superclass

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    p "I'm a fake instance"
  end
end

# child = Child.new
# child.say_hi      # => "Hi from Child."

# son = Child.new
# son.send :say_hi

# lad = Child.new
# lad.send :say_hi # Throws ArgumentError because our overridden send
  # is not expecting a symbol argument (or any argument)

# c = Child.new
# p c.instance_of? Child  # => True
# p c.instance_of? Parent # => False

heir = Child.new
heir.instance_of? Child # Throws an ArgumentError, same reason as above