=begin
Explain what the @@cats_count variable does and how it works.
@@cats_count is a class variable. It is initialized in the class with the @@ prefix
so we know it is a class variable. It is incremented every time a new object of
the class is instantiated because of the @@cats_count += 1 line within the initialize
constructor method. It is accessible by the class method cats_count.

Because it is a class variable, @@cats_count is accessible within class and instance
methods and available to both the class and the instances of the class.

What code would you need to write to test your theory?
p Cat.cats_count
tom = Cat.new("alley")
p Cat.cats_count

=end

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

p Cat.cats_count
tom = Cat.new("Alley")
p Cat.cats_count