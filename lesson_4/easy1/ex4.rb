=begin
If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like the code below.

We create a new instance of the AngryCat class by invoking the #new instance
method on the class name:

AngryCat.new

We can initialize a local variable to reference this new object for use:
catbert = AngryCat.new

=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

catbert = AngryCat.new