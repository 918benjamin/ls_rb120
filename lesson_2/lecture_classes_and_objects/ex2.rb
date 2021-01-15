# Modify the class definition from above to facilitate the following methods.
# Note that there is no name= setter method now.

### My Solution (Person class)
# class Person
#   attr_reader :name, :first_name, :last_name

#   def initialize(name)
#     @first_name = name
#     @last_name = ''
#     full_name
#   end

#   def first_name=(name)
#     @first_name = name
#     full_name
#   end

#   def last_name=(name)
#     @last_name = name
#     full_name
#   end

#   def full_name
#     @name = "#{@first_name} #{@last_name}"
#   end
# end

### LS Solution
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

### Given code
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'