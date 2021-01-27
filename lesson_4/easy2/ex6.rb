=begin
Which one of these is a class method (if any) and how do you know?
manufacturer is a class method because it is defined with the self. prefix
which references the class outside of an instance method.

How would you call a class method?
Call a class method on the class name:
ClassName.class_method

Example: Television.manufacturer


=end
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end