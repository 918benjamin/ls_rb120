=begin
Design a Sports Team Do a Spike
- Include 4 players (attacker, midfielder, defender, goalkeeper)
- All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
- All players can run and shoot the ball.
- Attacker should be able to lob the ball
- Midfielder should be able to pass the ball
- Defender should be able to block the ball
- The referee has a whistle. He wears black and is able to run and whistle.

Nouns
- Team
- Player: attacker
- Player: midfielder
- Player: defender
- Player: goalkeeper
- referee
  - has whistle

all players and referee have shirt/jersey color


Verbs
  - Run (all players and referee)
  - shoot (shoot the ball, all players)
  - lob (attacker player only)
  - pass (midfielder only)
  - block (defender only)

**V2**
GameEngine
  - attribute - team 1
  - attribute - team 2
  - attribute - referee
  - behavior - play game

Team Class
  - attribute - players (array)

Participant Class
  behavior - run
  attribute - shirt_color
  
  2 types
  
  - player class (Participant subclass)
    behavior - shoot
    
    3 players (each are player sublcass)
      - midfielder - pass
      - attacker - lobs
      - defender - blocks
  
  - referee class (participant subclass)
    - attribute - whistle = true
    - behavior - blow_whistle
    
    
Assumption:
- players and referees can share the shirt_color attribute vs making a jersey_color attribute of Player class and a uniform_color attribute of Referee class
=end


class Team
  def initialize
    @players = [] # creating a space for a Team object 
  end
  
  # Might be code here to initialize a team in a special way. Simple for now
end

class Participant
  attr_reader :shirt_color
  
  def initialize
    @shirt_color = self.class::SHIRT_COLOR
  end
  
  def run
    puts "I'm running!"
  end
end

class Player < Participant
  SHIRT_COLOR = "blue"
  
  def shoot
    puts "I'm shooting the ball!"
  end
end

class Attacker < Player
  def lob
    puts "I'm lobbing the ball!"
  end
end

class Midfielder < Player
  def pass
    puts "I'm passing the ball!"
  end
end

class Defender < Player
  def block
    puts "I'm blocking the ball!"
  end
end

class Goalkeeper < Player
  SHIRT_COLOR = "white with blue stripes"
end

class Referee < Participant
  SHIRT_COLOR = "black"
  
  def initialize
    super
    @has_whistle = true
  end
  
  def whistle
    puts "PHEEEEEEEEEW" if has_whistle
  end
  
  private
  
  attr_reader :has_whistle
end

attacker = Attacker.new
midfielder = Midfielder.new
defender = Defender.new
goalkeeper = Goalkeeper.new
referee = Referee.new

p attacker.shirt_color == "blue"
p midfielder.shirt_color == "blue"
p defender.shirt_color == "blue"
p goalkeeper.shirt_color
p referee.shirt_color == "black"


attacker.lob
midfielder.pass
defender.block
referee.whistle
p referee.shirt_color



module Runnable
  def initialize(jersey_color = "Blue")
    @jersey = Jersey.new(jersey_color)
  end
  
  def run
  end
end

class SportsTeam
  def initialize(name)
    @name = name
    @players = [] # Will hold `Player` instances
  end
end

class Player
  include Runnable
  
  def shoot
  end
end

class Attacker < Player
  def lob
  end
end

class Midfielder < Player
  def pass
  end
end

class Defender < Player
  def block
  end
end

class Goalkeeper < Player
  def initialize
    super("White with blue stripes")
  end
end

class Jersey
  def initialize(color)
    @color = color
  end
end

class Referee
  include Runnable
  
  def initialize
    super("Black")
  end
  
  def whistle
  end
end

goalkeep = Goalkeeper.new
p goalkeep
