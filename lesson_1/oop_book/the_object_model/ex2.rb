# What is a module? What is its purpose? How do we use them with our classes?
# A module contains methods and attributes we want to repeat in multiple classes.
# We use modules by mixing them into our classes using the `include` method invocation.


# Create a module for the class you created in exercise 1 and include it properly.
module Sit
  def sit
    puts "Ok, I'm sitting!"
  end
end

class GoodBoy
  include Sit
end

boy = GoodBoy.new

boy.sit

