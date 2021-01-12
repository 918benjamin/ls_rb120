=begin
Move all of the methods from the MyCar class that also pertain to the MyTruck
class into the Vehicle class.

Make sure that all of your previous method calls are working when you are finished.

=end

module FourWheelDriveable
  def four_wheel_drive
    puts "Four wheel drive engaged!"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def self.vehicles
    puts "There are #{@@number_of_vehicles} vehicles"
  end

  def self.gas_milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
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
    puts "Your new #{color} paint job looks great!"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "My car is a #{color} #{year} #{model}."
  end
end

class MyTruck < Vehicle
  include FourWheelDriveable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{color} #{year} #{model}."
  end
end

rav = MyCar.new(2015, "white", "Rav4")
tundra = MyTruck.new(2019, "Silver", "Tundra")

rav.speed_up(30)
rav.current_speed

tundra.spray_paint("blue")