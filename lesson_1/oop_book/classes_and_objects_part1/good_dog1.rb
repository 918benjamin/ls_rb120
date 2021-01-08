class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end

  # def speak
  #   "#{@name} says arf!"
  # end

  def speak
    "#{name} says arf!"
  end

end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name
sparky.name = "Spartacus"
puts sparky.name
puts sparky.speak

# fido = GoodDog.new("Fido")
# puts fido.speak