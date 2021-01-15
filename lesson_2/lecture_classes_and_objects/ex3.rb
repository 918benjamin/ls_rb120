# Now create a smart name= method that can take just a first name or a full
# name, and knows how to set the first_name and last_name appropriately.

### My solution (Person class)
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
end

### LS Solution
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parse_full_name(full_name)
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     parse_full_name(full_name)
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.size > 1 ? parts.last : ''
#   end
# end

### Given code
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
p bob.name