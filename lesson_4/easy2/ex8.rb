=begin
What can we add to the Bingo class to allow it to inherit the play method from
the Game class?

< Game


=end

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

bingo = Bingo.new
p bingo.play