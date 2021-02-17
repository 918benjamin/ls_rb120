class Participant
  attr_accessor :name
end

class Player < Participant
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards to produce" a total
  end
end

class Dealer < Participant
  NAMES = %w(Bryce, Edward, Arnold, Russ, Don, Ken, Stanford, Tommy)
  HIT_UNDER = 17

  def initialize
    # seems like very similar to player, do we even need this?
  end

  def deal
    # does the dealer or the deck deal
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  # what goes in here? All the redundant behaviors from Player and Dealer?
end

class Deck
  def initialize
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
  end

  def deal
    # does the dealer or the deck deal?
  end
end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    assign_names # prompt the user for their name and assign the dealer a cool name
    display_welcome_message
    loop do
      play_round
      determine_winner
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :player, :dealer

  def play_round
      reset_and_shuffle # shuffle the deck and reset the scores
      deal
      player_turn
      return if busted?
      dealer_turn
  end

  def assign_names
    prompt_for_name
    assign_dealer_name
  end

  def prompt_for_name
    clear_screen
    loop do
      puts "What's your name, friend?"
      player.name = gets.chomp.capitalize
      break unless player.name.empty?
      puts "I don't think that's your name... put something at least!"
    end
  end

  def assign_dealer_name
    dealer.name = Dealer::NAMES.sample
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to TwentyOne, #{player.name}!"
    puts ""
    puts "Here's how we play"
    puts "- You and the dealer, #{dealer.name}, both get two cards."
    puts "- You'll go first: hit or stay. If you go over 21, you bust."
    puts "- Once you stay, #{dealer.name} plays. He'll hit if his hand total"\
         "is less than #{Dealer::HIT_UNDER}."
    puts "- Whoever has the closest to 21 without busting, wins."
    puts ""
  end

  def reset_and_shuffle
  end

  def clear_screen
    system 'cls'
    system 'clear'
  end
end

Game.new.start