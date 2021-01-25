def clear_screen
  system "clear"
  system "cls"
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Rock < Move
  def >(other)
    other.class == Lizard || other.class == Scissors
  end

  def <(other)
    other.class == Paper || other.class == Spock
  end
end

class Paper < Move
  def >(other)
    other.class == Rock || other.class == Spock
  end

  def <(other)
    other.class == Scissors || other.class == Lizard
  end
end

class Scissors < Move
  def >(other)
    other.class == Paper || other.class == Lizard
  end

  def <(other)
    other.class == Spock || other.class == Rock
  end
end

class Lizard < Move
  def >(other)
    other.class == Spock || other.class == Paper
  end

  def <(other)
    other.class == Rock || other.class == Scissors
  end
end

class Spock < Move
  def >(other)
    other.class == Scissors || other.class == Rock
  end

  def <(other)
    other.class == Lizard || other.class == Paper
  end
end

class Player
  attr_accessor :move, :name, :score, :move_log

  def initialize
    set_name
    @score = 0
    @move_log = []
  end

  def new_move(choice)
    case choice.downcase
    when 'rock' then Rock.new(choice)
    when 'paper' then Paper.new(choice)
    when 'scissors' then Scissors.new(choice)
    when 'lizard' then Lizard.new(choice)
    when 'spock' then Spock.new(choice)
    end
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      clear_screen
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts ""
      puts "Sorry, you must enter a value."
    end
    self.name = n
    puts ""
    clear_screen
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{Move::VALUES.join(', ')}"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      clear_screen
      puts "Sorry, invalid choice."
    end
    puts ""
    self.move = new_move(choice)
    move_log << move
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = new_move(Move::VALUES.sample)
    move_log << move
  end
end

# Game Orchestration Engine
class RPSGame
  WINNING_SCORE = 3
  WINNING_VERBS = ['crushed', 'beat', 'obliterated', 'annihilated', 'trounced',
                 'destroyed', 'defeated', 'conquered', 'vanquished', 'quashed']

  attr_accessor :human, :computer, :rounds, :winner_log

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = 1
    @winner_log = []
  end

  def display_welcome_message
    puts "Welcome to #{Move::VALUES.join(', ')} #{human.name}!"
    puts "First one to win #{WINNING_SCORE} rounds is the grand winner!"
    puts ""
  end

  def display_goodbye_message
    clear_screen
    puts "Thank you for playing. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_and_scores
    puts "Round: #{rounds}"
    puts "----Scores----"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts "--------------"
    puts ""
  end

  def play_round
    display_round_and_scores
    human.choose
    computer.choose
    display_moves
    determine_winner
    display_winner
  end

  def determine_winner
    winner = nil
    if human.move > computer.move
      winner = human
    elsif human.move < computer.move
      winner = computer
    end
    winner_log << winner
    winner.score += 1 if winner
    self.rounds += 1
  end

  def display_winner
    if winner_log[-1]
      puts "#{winner_log[-1].name} won!"
    else
      puts "It's a tie!"
    end
    puts ""
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def determine_grand_winner # TODO: integrate this in and adjust display_grand_winner to match
    if human.score > computer.score
      human
    elsif human.score < computer.score
      computer
    else
      "tie"
    end
  end

  def display_grand_winner
    puts "Calculating final score..."
    sleep(2)
    clear_screen
    puts "After #{rounds - 1} rounds:"
    if human.score > computer.score
      puts "#{human.name} is the grand winner with #{human.score} wins!"
    elsif human.move < computer.move
      puts "#{computer.name} is the grand winner with #{computer.score} wins!"
    else
      puts "It's a tie! Bummer."
    end
    puts ""
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      clear_screen
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def stop_early?
    answer = nil

    loop do
      puts "Continue to next round? hit Enter to continue, `n` to stop early."
      answer = gets.chomp.downcase
      break if ['', 'n'].include?(answer)
      clear_screen
      puts "Sorry, only use Enter or n."
    end

    answer == 'n'
  end

  def reset_rounds_and_scores
    human.score = 0
    human.move_log = []
    computer.score = 0
    computer.move_log = []
    self.rounds = 1
    self.winner_log = []
    clear_screen
  end

  def view_move_log? # TODO Refactor the three related methods into one with arguments
    answer = nil

    loop do
      puts "Would you like to view the round history? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      clear_screen
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def display_move_history
    puts ""
    puts "*****Round History*****"
    winner_log.each_with_index do |winner, index|
      if winner
        loser = (winner == human ? computer : human)
        puts "Round #{index + 1}: #{winner.name}'s #{winner.move_log[index]} #{WINNING_VERBS.sample} #{loser.name}'s #{loser.move_log[index]}"
      else
        puts "Round #{index + 1}: You tied this round with #{human.move_log[index]}."
      end
    end
    puts ""
  end

  def play
    display_welcome_message
    loop do
      loop do
        play_round
        break if grand_winner? || stop_early?
        clear_screen
      end
      display_grand_winner
      display_move_history if view_move_log?
      break unless play_again?
      reset_rounds_and_scores
    end
    display_goodbye_message
  end
end

# Instantiate RPS object and invoke the #play method to begin the game
RPSGame.new.play

# rubocop:disable Layout/LineLength
=begin
RPS Bonus Features (Instructions and my thoughts/notes)

- Keeping score
  Right now, the game doesn't have very much dramatic flair. It'll be more
  interesting if we were playing up to, say, 10 points. Whoever reaches 10 points
  first wins. Can you build this functionality? We have a new noun -- a score. Is
  that a new class, or a state of an existing class? You can explore both options
  and see which one works better.

  Notes:
    - 10 points is a constant vs magic number
    - Score as class
      - Needs to be flexible: a state that stores both the human and computer scores
      - Could I implement every in this one class easier than as states?
        - comparing scores, determining a grand winner, etc.
    - Score as state
      - Easy to imagine a score as a state of a Player object
      - But then how do we compare the scores to determine a winner?
        Where does that code live?
    - Checklist
      [x] A structure to store the score of each Player (Human and Computer)
      [x] a mechanism for updating the score of the winning Player each round
        (BAD: display_winner method is doing too much)
      [x] a constant (winning rounds number) to hold the grand winning score (10)
      [x] a mechanism for checking if the grand winning score has been reached
            by either player (compare player scores to the winning rounds number)
      [x] a mechanism for asking the player if they want to continue to the
            next round or quit early
      [x] a mechanism for displaying the grand winner
        [x] display grand winner needs to reflect quitting early (ties)
      [x] a mechanism for restarting the whole game (adapt existing)
      [x] update the intro messaging to say how many rounds constitute a game
            "first to 10 games wins" for example
      [x] a mechanism to display the score and round number
          [x] keep track of total rounds (RPSengine instance variable?)
              (Related to future "history of rounds" bonus feature)
      Extra Bonus(my own ideas):
        [ ] Let the user choose how many rounds before a grand winner is chosen?
            (Is the winning rounds still a constant in this scenario?)
            (Is there such a thing as a user inputted constant?)
        [ ] ASCII art for the grand winner message?

- Add Lizard and Spock
  This is a variation on the normal Rock Paper Scissors game by adding two more
  options - Lizard and Spock. The full explanation and rules are here:
  http://www.samkass.com/theories/RPSSL.html

  Extra bonus(my own ideas)
  [ ] let the user choose rock paper scissors version or lizard spock version from the start

- Add a class for each move
  What would happen if we went even further and introduced 5 more classes, one
  for each move: Rock, Paper, Scissors, Lizard, and Spock. How would the code
  change? Can you make it work? After you're done, can you talk about whether
  this was a good design decision? What are the pros/cons?

  Pros/cons:
    - I did get it to work and it seems to be an OK design decision.
    - Con: I had to add some additional complexity in order to instantiate the right
        object since we can no longer just instantiate a single Move object.
    - Pro: I was able to elimitate much of the code from the Move class
    - Pro: I replaced the many or checks within the > and < Move instance methods
      - Replaced these with simpler versions within each individual move subclass

- Keep track of a history of moves
  As long as the user doesn't quit, keep track of a history of moves by both the
  human and computer. What data structure will you reach for? Will you use a new
  class, or an existing class? What will the display output look like?

  Notes:
    - Each round I need to keep track of the
      - round number (before it increments)
      - human object coupled with their move
      - computer object coupled with their move
    - Could use nested arrays with a pattern - [[round #, human move, computer move]]
    - Could use one instance variable of the RPS engine to store with no new classes
    - Could create instance variable within the player class to store their own move
      - Then access it from within the RPS engine class
    - Display:
      Round 1: Player's Scissors beat Computer's Paper
      Round 2: ...

  Checklist:
    [x] Create move_log instance variable and attr_accessor in Player class
    [x] Initialize empty history: empty array
    [x] Method for outputting the move history if the user would like
      [x] Ask the user if they want to see history (before asking to play again)
      [x] Output the history. Format: Round 1: Player's Scissors beat Computer's Paper
    [x] Store each move to the history of that player (nested array)
    [x] Reset history if they play again

- Computer personalities
  We have a list of robot names for our Computer class, but other than the name,
  there's really nothing different about each of them. It'd be interesting to
  explore how to build different personalities for each robot. For example, R2D2
  can always choose "rock". Or, "Hal" can have a very high tendency to choose
  "scissors", and rarely "rock", but never "paper". You can come up with the
  rules or personalities for each robot. How would you approach a feature like this?

  Notes:
    -

Other ideas (my own bonus features):
  - Accept single letter user inputs (just like old RPS game)
  - "Rock paper scissors lizard, or spock" - add an 'and/or' method

- Notes from TA feedback on other code reviews:
  -

=end
# rubocop:enable Layout/LineLength
