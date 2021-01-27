=begin
What could we add to the class below to access the instance variable @volume?

We could add either a manual definition of a getter method:
def volume
  @volume
end

or an attr_reader method:
attr_reader :volume

We could also add an attr_accessor method, but that would add a setter method as
well and this question specifies "access" and not "modify"

LS Solution:
introduces the idea of the instance_variable_get method but says this isn't a great idea.
=end

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end