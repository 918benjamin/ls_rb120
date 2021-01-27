=begin
If we call Hello.hi we get an error message. How would you fix this?

Instantiate an object of the Hello class and then invoke hi on that class.

If we want a class method hi, we need to define one.

=end

class Greeting
  def greet(message)
    puts message
  end

  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello from #{self} class")
  end

  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# hello = Hello.new
# hello.hi

Hello.hi