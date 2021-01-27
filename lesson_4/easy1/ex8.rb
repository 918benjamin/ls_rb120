=begin
If we have a class such as the one below:
You can see in the make_one_year_older method we have used self.
What does self refer to here?

Self here refers to the instance that is invoking the make_one_year_older method.
Self is needed in this situation on order to distinguish this setter method call
to `age = age + 1` from local variable initialization/reassignment.

=end

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end