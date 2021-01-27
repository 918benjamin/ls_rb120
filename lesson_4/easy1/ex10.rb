=begin
If we have the class below, what would you need to call to create a new instance
of this class.

We need to call the #new method on Bag and pass in values for the color and material
as arguments.
=end

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

my_bag = Bag.new("purple", "snakeskin")
p my_bag