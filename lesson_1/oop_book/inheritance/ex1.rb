=begin
Create a superclass called Vehicle for your MyCar class to inherit from and move
the behavior that isn't specific to the MyCar class to the superclass.

Create a constant in your MyCar class that stores information about the vehicle
that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that
also has a constant defined that separates it from the MyCar class in some way.

=end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  def self.gas_milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You press on the accelerator and speed up #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You press on the brake and slow down #{number} mph."
  end

  def turn_off
    @current_speed = 0
    puts "You stop and take the keys out."
  end

  def current_speed
    puts "Your current speed is #{@current_speed} mph."
  end

  def spray_paint(color)
    self.color = color
    puts "Your car is now a shiny shade of #{color}"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "My car is a #{color} #{year} #{model}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{color} #{year} #{model}."
  end
end

rav = MyCar.new(2015, "white", "Rav4")
tundra = MyTruck.new(2019, "Silver", "Tundra")

puts rav
puts tundra
