# Continuing with our Person class definition, what does the below print out?

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"

### My code from ex3
# class Person
#   attr_reader :name, :first_name, :last_name

#   def initialize(name)
#     update_name(name)
#   end

#   def first_name=(name)
#     self.name = "#{name} #{last_name}"
#   end

#   def last_name=(name)
#     self.name = "#{first_name} #{name}"
#   end
  
#   def name=(name)
#     update_name(name)
#   end

#   def update_name(name)
#     parts = name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#     @name = "#{@first_name} #{@last_name}".strip
#   end
# end

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"

# This will print out the object id (something like #<Person:0x###>)

# Let's add a to_s method to the class:

### My code from ex3
class Person
  attr_reader :name, :first_name, :last_name

  def initialize(name)
    update_name(name)
  end

  def first_name=(name)
    self.name = "#{name} #{last_name}"
  end

  def last_name=(name)
    self.name = "#{first_name} #{name}"
  end
  
  def name=(name)
    update_name(name)
  end

  def update_name(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
    @name = "#{@first_name} #{@last_name}".strip
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# Now what does the above output?

# It outputs the name itself in place of #{bob}