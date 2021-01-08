# Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_accessor :color
  attr_reader :year

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

rav = MyCar.new(2015, "white", "Rav4")

MyCar.gas_milage(13, 351)