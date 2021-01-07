=begin
Create a class called MyCar. When you initialize a new instance or object of the
class, allow the user to define some instance variables that tell us the year,
color, and model of the car. Create an instance variable that is set to 0 during
instantiation of the object to track the current speed of the car as well. Create
instance methods that allow the car to speed up, brake, and shut the car off.

=end

### My solution
# class MyCar
#   attr_accessor :year, :color, :model, :current_speed

#   def initialize(y, c, m)
#     self.year = y
#     self.color = c
#     self.model = m
#     self.current_speed = 0
#   end

#   def speed_up
#     self.current_speed += 5
#   end

#   def break
#     self.current_speed -= 5
#   end

#   def shut_down
#     self.current_speed = 0
#   end
# end

# rav = MyCar.new(2015, 'White', 'Rav4')
# puts "My car is a #{rav.year} #{rav.color} Toyota #{rav.model}"

# rav.speed_up
# rav.speed_up
# rav.speed_up
# puts rav.current_speed
# rav.break
# puts rav.current_speed
# rav.shut_down
# puts rav.current_speed

### LS Solution
class MyCar

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed