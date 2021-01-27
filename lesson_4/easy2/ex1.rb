=begin
What is the result of executing the following code:

Outputs a string, the combination of "You will " and one of the three options
in the array returned from the choices method.
=end

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future