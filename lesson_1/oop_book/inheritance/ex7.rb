=begin
Create a class 'Student' with attributes name and grade.

Do NOT make the grade getter public, so joe.grade will raise an error.

Create a better_grade_than? method, that you can call like so...



=end

class Student

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other)
    self.grade > other.grade
  end

  protected
  
  def grade
    @grade
  end

end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)

puts "Well done!" if joe.better_grade_than?(bob)
# puts joe.grade # checking to ensure that the instance method `grade` is protected
  # and therefore not accessible outside the class

