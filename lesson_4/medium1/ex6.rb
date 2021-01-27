=begin
What is the difference in the way the code works in these two examples?

The main difference is that the first example ignores the setter method in favor
explicitly reassigning @template within the create_template instance method.

Within the show_template method, the first example is invoking the template getter
without self and the second example invokes template getter on self. Both of these
do the same thing.

Functionally, both of these do exactly the same thing.
=end

# Example 1
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# Example 2
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end