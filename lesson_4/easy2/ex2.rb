=begin
We have an Oracle class and a RoadTrip class that inherits from the Oracle class.
What is the result of the following code?

Same as previous, but the ["visit Vegas", "fly to Fiji", "romp in Rome"] array
returned by the choices method redefined (overriden) in the RoadTrip class
will be used.

This is due to the method lookup path/resolution order
=end

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future