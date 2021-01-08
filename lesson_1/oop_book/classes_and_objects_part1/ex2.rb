=begin
Add an accessor method to your MyCar class to change and view the color of your
car. Then add an accessor method that allows you to view, but not modify, the
year of your car.

- Add accessor method to change+view color
- Add accessor method to view (-change) year

=end

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(c, y)
    self.color = c
    @year = y
  end
end

rav = MyCar.new('white', 2015)
p rav
rav.color = "grey"
p rav
rav.year = 2016
p rav