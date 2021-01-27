=begin
In the last question we had a module called Speed which contained a go_fast method.
We included this module in the Car class as shown below.

When we called the go_fast method from an instance of the Car class (as shown below)
you might have noticed that the string printed when we go fast includes the name
of the type of vehicle we are using. How is this done?

The string printed the name of the vehcile type because of the string interpolated
#{self.class} method call. self.class returns the class name of the instance,
since self refers to the instance that is invoking it. Even though the go_fast
method that contains #{self.class} is defined within the Speed module, when the module is
mixed into the Car class, the Car class gains this method through interface inheritance.
So when the go_fast method is invoked by an instance of the Car class, the code is basically
instance.class.
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

small_car = Car.new
small_car.go_fast
# => I am a Car and going super fast!