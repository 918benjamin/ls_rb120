def clear_screen
  system "clear"
  system "cls"
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (scissors? && other_move.paper?) ||
      (paper? && other_move.rock?) ||
      (rock? && other_move.lizard?) ||
      (lizard? && other_move.spock?) ||
      (spock? && other_move.scissors?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.paper?) ||
      (paper? && other_move.spock?) ||
      (spock? && other_move.rock?) ||
      (rock? && other_move.scissors?)
  end

  def <(other_move)
    (paper? && other_move.scissors?) ||
      (rock? && other_move.paper?) ||
      (lizard? && other_move.rock?) ||
      (spock? && other_move.lizard?) ||
      (scissors? && other_move.spock?) ||
      (lizard? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (spock? && other_move.paper?) ||
      (rock? && other_move.spock?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
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
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  WINNING_SCORE = 3

  attr_accessor :human, :computer, :rounds

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = 1
  end

  def display_welcome_message
    puts "Welcome to #{Move::VALUES.join(', ')} #{human.name}!"
    puts "First one to #{WINNING_SCORE} wins is the grand winner!"
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
    display_winner
  end

  def determine_winner #TODO
  end

  def display_winner # BAD: This method is now doing 3 things (calculating winner, displaying winner, updating score)
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
    self.rounds += 1
    puts ""
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def determine_grand_winner #TODO
  end

  def display_grand_winner
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
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      clear_screen
      puts "Sorry, must be y or n."
    end

    answer.downcase == 'y'
  end

  def stop_early?
    answer = nil

    loop do
      puts "Continue to next round? hit Enter to continue, `n` to stop early."
      answer = gets.chomp
      break if ['', 'n'].include?(answer.downcase)
      puts "Sorry, only use Enter or n."
      clear_screen
    end

    answer == 'n'
  end

  def reset_rounds_and_scores
    human.score = 0
    computer.score = 0
    self.rounds = 1
    clear_screen
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

  Notes:
    -

- Keep track of a history of moves
  As long as the user doesn't quit, keep track of a history of moves by both the
  human and computer. What data structure will you reach for? Will you use a new
  class, or an existing class? What will the display output look like?

  Notes:
    -

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
