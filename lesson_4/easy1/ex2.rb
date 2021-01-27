=begin
If we have a Car class and a Truck class and we want to be able to go_fast,
how can we add the ability for them to go_fast using the module Speed?

How can you check if your Car or Truck can now go fast?

Can check now by invoking the go_fast method (raises an exception) 
or invoking the ancestors method on the Car or Truck class to see if the Speed
module is already mixed in.

We can add the go_fast method to these classes by mixing in the Speed module
using the 'include Speed' syntax
=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

my_car = Car.new
my_car.go_fast

my_truck = Truck.new
my_truck.go_fast