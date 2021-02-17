class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key]
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      line_markers = line.map { |key| @squares[key].marker }.uniq
      if line_markers.count == 1 && line_markers.first != ' '
        return line_markers.first
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :marker, :name

  def initialize
    @score = 0
  end
end

class Computer < Player
  attr_accessor :next_best_move

  def initialize
    super
    @next_best_move = nil
  end
end

class TTTGame
  MARKER_OPTIONS = ["X", "O"]
  FIRST_TO_MOVE = 'choose'
  WINNING_ROUNDS = 5

  attr_reader :board, :human, :computer, :current_player
  attr_accessor :rounds

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Computer.new
    @rounds = 0
    @first_player = nil
  end

  def play
    assign_names
    display_welcome_message
    assign_markers
    assign_first_player
    main_game
    display_goodbye_message
  end

  private

  def assign_names
    clear_screen
    human.name = ask_player_name
    computer.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'NumberFive'].sample
  end

  def ask_player_name
    puts ""
    name = nil
    loop do
      puts "What's your name, friend?"
      name = gets.chomp
      break unless name.empty?
      clear_screen
      puts "Surely that's not it... what do people call you?"
    end
    name
  end

  def assign_first_player
    @first_player = case FIRST_TO_MOVE
                    when 'human' then human.marker
                    when 'computer' then computer.marker
                    when 'choose' then choose_first_player
                    end
  end

  def choose_first_player
    case human_choose_first_player[0]
    when human.name[0].downcase then human.marker
    when computer.name[0].downcase then computer.marker
    end
  end

  def human_choose_first_player
    choice = nil
    loop do
      puts "Who should go first? Enter #{formatted_name_selection}."
      choice = gets.chomp.downcase
      break if name_selection.include?(choice)
      clear_screen
      puts "Please enter either #{human.name} or #{computer.name}"\
           " or just the first letter of either name."
    end
    choice
  end

  def formatted_name_selection
    "(#{name_selection[0].upcase})#{name_selection[1][1..-1]} or"\
    " (#{name_selection[2].upcase})#{name_selection[3][1..-1]}"
  end

  def name_selection
    [human.name[0].downcase,
     human.name.downcase,
     computer.name[0].downcase,
     computer.name.downcase]
  end

  def assign_markers
    human.marker = choose_marker
    marker_options = MARKER_OPTIONS.clone
    marker_options.delete(human.marker)
    computer.marker = marker_options.first
  end

  def choose_marker
    puts ""
    choice = nil
    loop do
      puts "Would you like to play with X or O?"
      choice = gets.chomp.upcase
      break if MARKER_OPTIONS.include?(choice)
      clear_screen
      puts "Please enter either X or O."
    end
    choice
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def play_rounds
    loop do
      increment_rounds
      display_round_and_scores
      display_board
      player_move
      display_result
      increment_scores
      break if stop_early? || grand_winner?
      reset_round
    end
  end

  def main_game
    @current_player = @first_player
    loop do
      play_rounds
      display_grand_winner
      break unless play_again?
      display_play_again_message
      reset_game
    end
  end

  def grand_winner?
    human.score == WINNING_ROUNDS || computer.score == WINNING_ROUNDS
  end

  def determine_grand_winner
    case human.score <=> computer.score
    when 1 then 'player'
    when -1 then 'computer'
    when 0 then 'tie'
    end
  end

  def increment_scores
    case board.winning_marker
    when human.marker then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def increment_rounds
    self.rounds += 1
  end

  def display_grand_winner
    clear_screen
    puts "After #{rounds} games:"
    case determine_grand_winner
    when 'player' then puts "Congrats, #{human.name}! You are the grand winner"\
                            " with #{human.score} wins!"
    when 'computer' then puts "#{computer.name} is the grand winner this time"\
                              " with #{computer.score} wins."
    when 'tie'
      puts "It's a tie. Bummer!"
    end
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to Tic Tac Toe, #{human.name}!"
    puts ""
    puts "You are playing against #{computer.name}, the meanest TicTacToe"\
         " bot around!"
    puts ""
    puts "The first of you to reach #{WINNING_ROUNDS} wins is the grand winner!"
    puts ""
  end

  def display_goodbye_message
    clear_screen
    puts "Thanks for playing Tic Tac Toe, #{human.name}! Goodbye!"
  end

  def display_round_and_scores
    puts "**** Game #{rounds} ****"
    puts "Scores: #{human.name} has #{human.score},"\
    " #{computer.name} has #{computer.score}"
    puts ""
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_unmarked_keys
    joinor(board.unmarked_keys)
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def human_moves
    puts "Choose a square (#{display_unmarked_keys}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def immediate_threat?
    detect_best_move(human)
    computer.next_best_move
  end

  def detect_best_move(player)
    board.class::WINNING_LINES.each do |line|
      taken_squares = line.count { |key| board[key].marker == player.marker }

      if taken_squares == 2
        line.each do |key|
          computer.next_best_move = key if board[key].unmarked?
        end
      end
    end
  end

  def chance_to_win?
    detect_best_move(computer)
    computer.next_best_move
  end

  def computer_moves
    square = if chance_to_win? || immediate_threat?
               computer.next_best_move
             elsif board[5].unmarked?
               5
             else
               board.unmarked_keys.sample
             end
    board[square] = computer.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = computer.marker
    else
      computer_moves
      @current_player = human.marker
    end
    computer.next_best_move = nil
  end

  def display_result
    clear_screen
    display_board

    case board.winning_marker
    when human.marker then puts "You won!"
    when computer.marker then puts "Computer won!"
    else puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    puts ""
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry, must be (y)es or (n)o."
    end

    answer.start_with?('y')
  end

  def stop_early?
    answer = nil

    loop do
      puts "Continue to next round? hit Enter to continue, (n)o to stop early."
      answer = gets.chomp.downcase
      break if ['', 'n', 'no'].include?(answer)
      clear_screen
      puts "Sorry, only use Enter or no (n works too)."
    end
    answer.start_with?('n')
  end

  def reset_round
    board.reset
    @current_player = @first_player
    clear_screen
  end

  def reset_game
    reset_round
    human.score = 0
    computer.score = 0
    self.rounds = 0
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def human_turn?
    @current_player == human.marker
  end

  def joinor(arr, delimiter=', ', conjunction='or')
    if arr.size < 2
      arr.join(delimiter)
    else
      last_item = arr.pop
      arr.join(delimiter) + delimiter + conjunction + ' ' + last_item.to_s
    end
  end

  def clear_screen
    system("clear") || system("cls")
  end
end

game = TTTGame.new
game.play
