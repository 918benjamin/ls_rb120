=begin
An Application: Bicycles and Gears

Bicycles have 2 wheels
Gears: Small gears, Big gears, Other gears

Small:
chainring = 52
cog = 11
ratio = chainring / cog.to_f

Big:
chainring = 30
cog = 27
ratio = chainring / cog.to_f

other:
chainring = 34
cog = 29
ratio = chainring / cog.to_f

Create an application that prints out each gear ratio.

=end

class Bicycle
  def initialize
    @wheels = [Wheel.new, Wheel.new]
    @gears = [SmallGear.new, BigGear.new, OtherGear.new]
  end
  
  def print_gear_ratios
    gears.each do |gear|
      puts gear.ratio
    end
  end
  
  private
  
  attr_reader :gears
end

class Wheel
  # definitely something here but not specified
  # might have attributes for radius/dimensions, air in tires vs flat tire, number of spokes
  # might have behaviors like flat_tire?
end

class Gear
  def initialize
    @chainring = self.class::CHAINRING
    @cog = self.class::COG
  end
  
  def ratio
    chainring / cog.to_f
  end
  
  private
  
  attr_reader :chainring, :cog
end

class SmallGear < Gear
  CHAINRING = 52
  COG = 11
end

class BigGear < Gear
  CHAINRING = 30
  COG = 27
end

class OtherGear < Gear
  CHAINRING = 34
  COG = 29
end

bike = Bicycle.new
bike.print_gear_ratios

class Application
  def initialize
    @bicycle = Bicycle.new([SmallGear.new, OtherGear.new, BigGear.new])
  end
  
  def print_ratio #print each ratio from the bicycle gears array
    @bicycle.gears.each do |gear|
      puts gear.ratio
    end
  end
end

class Bicycle
  attr_reader :gears
  
  def initialize(gears)
    @wheels = [Wheel.new, Wheel.new]
    @gears = gears #This is an array of Gear instances
  end
end

class Gear
  attr_reader :ratio
  
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
    @ratio = chainring / cog.to_f
  end
end

class SmallGear < Gear
  def initialize
    super(52, 11)
  end
end

class BigGear < Gear
  def initialize
    super(30, 27)
  end
end

class OtherGear < Gear
  def initialize
    super(34, 29)
  end
end

class Wheel
end

bikeap = Application.new
bikeap.print_ratio