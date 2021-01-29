require "pry"
require "pry-byebug"

module Clearable
  def clear_screen
    system "clear"
    system "cls"
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  attr_reader :beats

  def initialize(value)
    @value = value
    @beats = nil
  end

  def to_s
    @value
  end

  def >(other)
    beats.any? { |lesser_move| other.class == lesser_move }
  end
end

class Rock < Move
  def initialize(value)
    super
    @beats = [Lizard, Scissors]
  end
end

class Paper < Move
  def initialize(value)
    super
    @beats = [Rock, Spock]
  end
end

class Scissors < Move
  def initialize(value)
    super
    @beats = [Paper, Lizard]
  end
end

class Lizard < Move
  def initialize(value)
    super
    @beats = [Spock, Paper]
  end
end

class Spock < Move
  def initialize(value)
    super
    @beats = [Scissors, Rock]
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
  include Clearable

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

  def prompt_for_choice
    loop do
      puts "Please choose #{Move::VALUES.join(', ')}"
      if move_log.empty?
        puts "Single letter abbreviations are OK."\
             " Use two letters for (sc)issors or (sp)ock"
      end

      choice = gets.chomp.downcase
      return choice if valid_choice?(choice)
      puts "Sorry, invalid choice."
    end
  end

  def choose
    choice = prompt_for_choice
    self.move = new_move(format_choice(choice))
    move_log << move
  end
end

class Computer < Player
  attr_reader :computer_moves

  def initialize
    @personality = generate_personality
    @computer_moves = personality.moves
    super
  end

  def set_name
    self.name = personality.name
  end

  def generate_personality
    [R2D2.new, Hal.new, Chappie.new, Sonny.new, NumberFive.new].sample
  end

  def choose
    self.move = new_move(computer_moves.sample)
    move_log << move
  end

  private

  attr_reader :personality
end

class Personality
  attr_reader :moves, :name

  MOVE_RATIOS = { rock: 0.2, paper: 0.2, scissors: 0.2, lizard: 0.2,
                  spock: 0.2 }

  def initialize
    @moves = generate_moves
    @name = self.class.to_s
  end

  def generate_moves
    self.class::MOVE_RATIOS.each_with_object([]) do |(move, ratio), arr|
      (ratio * 100).to_i.times { arr << move.to_s }
    end
  end
end

class R2D2 < Personality
  MOVE_RATIOS = { rock: 1, paper: 0, scissors: 0, lizard: 0, spock: 0 }
end
class Hal < Personality
  MOVE_RATIOS = { rock: 0.1, paper: 0, scissors: 0.6, lizard: 0.2, spock: 0.1 }
end

class Chappie < Personality
  MOVE_RATIOS = { rock: 0.15, paper: 0.15, scissors: 0.15, lizard: 0.4,
                  spock: 0.15 }
end

class Sonny < Personality
  MOVE_RATIOS = { rock: 0.25, paper: 0.25, scissors: 0.25, lizard: 0.25,
                  spock: 0 }
end

class NumberFive < Personality
  MOVE_RATIOS = { rock: 0, paper: 0, scissors: 0, lizard: 0.5, spock: 0.5 }
end

# Game Orchestration Engine
class RPSGame
  WINNING_SCORE = 3
  WINNING_VERBS = ['crushed', 'beat', 'obliterated', 'annihilated', 'trounced',
                   'destroyed', 'defeated', 'conquered', 'vanquished',
                   'quashed']

  include Clearable

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = 1
    @winner_log = []
  end

  # rubocop:disable Metrics/MethodLength
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

  private

  attr_accessor :human, :computer, :rounds, :winner_log

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
    elsif computer.move > human.move
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end

# Instantiate RPS object and invoke the #play method to begin the game
RPSGame.new.play
