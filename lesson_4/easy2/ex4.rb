=begin
What could you add to this class to simplify it and remove two methods from the
class definition while still maintaining the same functionality?

The manual definitions of setter and getter methods for @type instance variable
can be created using the attr_accessor method with :type as an argument

On second thought, the getter method isn't being used at all right now so we
could do away with the accessor methods entirely and skip the attr_accessor
and maintain the same functionality.

=end

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

bees_wax = BeesWax.new("cloudy")
bees_wax.describe_type