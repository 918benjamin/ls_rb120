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
    case choice
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
    clear_screen
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      clear_screen
      puts "Sorry, you must enter a value."
    end
    self.name = n
  end

  def valid_choice?(choice)
    move_arr = Move::VALUES.select do |value|
      value.start_with?(choice)
    end

    move_arr.count == 1
  end

  def format_choice(choice)
    move_arr = Move::VALUES.select do |value|
      value.start_with?(choice)
    end

    move_arr.first
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{Move::VALUES.join(', ')}"
      if move_log.empty? || choice
        puts "Abbreviations are OK - use two letters for (sc)issors or (sp)ock"
      end

      choice = gets.chomp.downcase
      break if valid_choice?(choice)
      puts "Sorry, invalid choice."
    end

    choice = format_choice(choice)
    self.move = new_move(choice)
    move_log << move
  end
end

class Computer < Player
  attr_reader :computer_moves

  def initialize
    super
    @computer_moves = generate_personality
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def generate_personality
    case name
    when 'R2D2' then ['rock']
    when 'Hal' then %w(scissors scissors scissors rock lizard lizard spock)
    when 'Chappie' then %w(spock spock lizard lizard lizard rock paper scissors)
    when 'Sonny' then %w(rock rock paper paper scissors scissors lizard lizard)
    when 'Number 5' then %w(lizard spock)
    else %w(rock paper scissors lizard spock)
    end
  end

  def choose
    self.move = new_move(computer_moves.sample)
    move_log << move
  end
end

# Game Orchestration Engine
class RPSGame
  WINNING_SCORE = 3
  WINNING_VERBS = ['crushed', 'beat', 'obliterated', 'annihilated', 'trounced',
                   'destroyed', 'defeated', 'conquered', 'vanquished',
                   'quashed']

  attr_accessor :human, :computer, :rounds, :winner_log

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = 1
    @winner_log = []
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to #{Move::VALUES.join(', ')} #{human.name}!"
    puts "First one to win #{WINNING_SCORE} rounds is the grand winner!"
    puts ""
  end

  def display_goodbye_message
    clear_screen
    puts "Thank you for playing. Goodbye!"
  end

  def display_moves
    puts ""
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

  def determine_grand_winner
    puts "Calculating final score..."
    sleep(2)
    clear_screen

    if human.score > computer.score
      human
    elsif human.score < computer.score
      computer
    end
  end

  def display_grand_winner
    winner = determine_grand_winner
    puts "After #{rounds - 1} rounds:"
    if winner
      puts "#{winner.name} is the grand winner with #{winner.score} wins!"
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
      break if ['y', 'n', 'yes', 'no'].include?(answer)
      clear_screen
      puts "Sorry, must be y or n."
    end

    answer.start_with?('y')
  end

  def stop_early?
    answer = nil

    loop do
      puts "Continue to next round? hit Enter to continue, `n` to stop early."
      answer = gets.chomp.downcase
      break if ['', 'n', 'no'].include?(answer)
      clear_screen
      puts "Sorry, only use Enter or n."
    end
    clear_screen
    answer.start_with?('n')
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

  def view_move_log?
    answer = nil

    loop do
      puts "Would you like to view the round history? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include?(answer)
      clear_screen
      puts "Sorry, must be y or n."
    end
    puts ""

    answer.start_with?('y')
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def display_move_history
    puts ""
    puts "*****Round History*****"
    winner_log.each_with_index do |winner, index|
      round = index + 1
      if winner
        loser = (winner == human ? computer : human)
        puts "Round #{round}: #{winner.name}'s #{winner.move_log[index]}"\
        " #{WINNING_VERBS.sample} #{loser.name}'s #{loser.move_log[index]}"
      else
        puts "Round #{round}: You tied this round with "\
        "#{human.move_log[index]}."
      end
    end
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  def play
    display_welcome_message
    loop do
      loop do
        play_round
        break if grand_winner? || stop_early?
      end
      display_grand_winner
      display_move_history if view_move_log?
      break unless play_again?
      reset_rounds_and_scores
    end
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength
end

# Instantiate RPS object and invoke the #play method to begin the game
RPSGame.new.play
