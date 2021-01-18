# Draw a class hierarchy diagram of the classes from step #2

# Pet - superclass
  # Instance methods - run and jump
# Subclasses of Pet - Dog & Cat 
  # Cat instance methods - speak
  # Dog instance methods - speak, fetch, swim
    # Bulldog subclass of Dog
      # Instance method - swim

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end