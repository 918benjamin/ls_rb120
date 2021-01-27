=begin
In the name of the cats_count method we have used self.
What does self refer to in this context?

Since this self is outside an instance method, this self refers to the class.
This defines cats_count as a class method instead of an instance method.

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