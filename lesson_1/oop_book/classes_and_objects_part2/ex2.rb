# Override the to_s method to create a user friendly print out of your object.

class MyCar
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

  def to_s
    "My car is a #{color} #{year} #{model}."
  end
end

rav = MyCar.new(2015, "white", "Rav4")
puts rav

