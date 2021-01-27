=begin
What happens in each of the following cases
=end

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
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
# => outputs "Hello"

# hello = Hello.new
# hello.bye
# => NoMethodError (no bye instance method for Hello class)

# hello = Hello.new
# hello.greet
# => ArgumentError - missing an argument for the greet method

# hello = Hello.new
# hello.greet("Goodbye")
# => outputs "Goodbye" 

Hello.hi
# NoMethodError - no class method hi for class Hello (it's an instance method)