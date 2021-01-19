class Animal
  def eat
    puts "Animal eats"
  end
end

class Fish < Animal
  def eat
    puts "Fish eats"
  end
end

class Cat < Animal
  def eat
    puts "Cat eats"
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Cat.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end