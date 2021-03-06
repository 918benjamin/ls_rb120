require "pry"
require "pry-byebug"

class Participant
  BUST_NUMBER = 21

  attr_accessor :name, :hand, :stay

  def initialize
    reset
  end

  # def hit
  # end

  # def stay
  # end

  def busted?
    total > BUST_NUMBER
  end

  def total
    hand.reduce(0) { |sum, card| sum += card.value}
  end

  def reset
    @hand = []
    @stay = false
  end
end

class Player < Participant; end

class Dealer < Participant
  NAMES = %w(Bryce Edward Arnold Russ Don Ken Stanford Tommy)
  HIT_UNDER = 17
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    shuffle
  end

  def draw
    shuffle if cards.empty?
    cards.pop
  end

  def shuffle
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
end

class Card
  RANK_VALUES = {'Jack' => 10,
    'Queen' => 10,
    'King' => 10,
    'Ace' => [11, 1] # TODO: gonna be a problem
   }

  include Comparable

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    value <=> other.value
  end

  def value
    case rank
    when 'Ace'
      RANK_VALUES.fetch(rank, rank)[0]
    else
      RANK_VALUES.fetch(rank, rank) # TODO: handle aces
    end
  end
end

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = nil
    @winner = nil
    @loser = nil
  end

  def start
    assign_names
    display_welcome_message
    enter_to_begin
    loop do
      play_round
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :player, :dealer, :deck, :winner, :loser

  def play_round
      reset_and_shuffle
      deal
      player_turn
      return if player.busted?
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
      puts "I don't think that's your name... put something please!"
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
         " is less than #{Dealer::HIT_UNDER}."
    puts "- Whoever has the closest to 21 without busting, wins."
  end

  def display_goodbye_message
    clear_screen
    puts "Thanks for playing, #{player.name}!"
    puts "Goodbye"
  end

  def enter_to_begin
    puts ""
    loop do
      print "Hit enter to get started"
      choice = gets.chomp
      break if choice == ''
      puts "Invalid. Don't type anything, just hit enter"
      puts ""
    end
  end

  def reset_and_shuffle
    self.deck = Deck.new
    player.reset
    dealer.reset
  end

  def deal
    2.times do
      player.hand << deck.draw
      dealer.hand << deck.draw 
    end
  end

  def player_turn
    loop do
      display_hands
      hit_or_stay
      break if player.stay || player.busted?
    end
  end

  def dealer_turn
    loop do
      break if dealer.total > Dealer::HIT_UNDER || dealer.busted?
      puts "#{dealer.name} hits"
      sleep 2
      dealer.hand << deck.draw

    end
    puts "#{dealer.name} " + (dealer.busted? ? "busted" : "stays")
    sleep 2
  end

  def display_hands
    # TODO: dry this up and adapt it to work for both during gameplay and
          # displaying results (both full hands)
    clear_screen
    puts "---Current hands---"
    puts "#{dealer.name} has #{dealer.hand[0].rank} of #{dealer.hand[0].suit}"\
         " & unknown"
    print "#{player.name} has "
    player.hand.each_with_index do |card, index|
      print "#{card.rank} of #{card.suit}"
      print ' & ' unless index == player.hand.size - 1
    end
    puts ""
  end

  def hit_or_stay
    prompt_for_choice.start_with?('h') ? player_hits : player_stays
  end

  def player_hits
    player.hand << deck.draw
  end

  def player_stays
    puts ""
    puts "You stay"
    player.stay = true
  end

  def display_winner
    clear_screen
    puts "Final score of this round:"
    determine_winner
    if winner == 'tie'
      puts "It's a tie!" 
      puts "#{player.name} and #{dealer.name} both had #{player.total} total"
      return
    end
    puts "#{winner.name} is the winner with #{winner.total} total"
    print "#{loser.name} suffered a crushing blow with #{loser.total} total"
    print "#{' (busted)' if loser.busted?}"
    puts ""
  end

  def determine_winner
    case
    when player.busted? then set_winner(dealer)
    when dealer.busted? then set_winner(player)
    when player.total > dealer.total then set_winner(player)
    when player.total < dealer.total then set_winner(dealer)
    else self.winner = 'tie'
    end
  end

  def set_winner(winner)
    participants = [player, dealer]
    participants.delete(winner)

    self.winner = winner
    self.loser = participants.first
  end
  
  def prompt_for_choice
    choice = nil
    loop do
      puts ""
      puts "Do you want to (h)it or (s)tay?"
      choice = gets.chomp.downcase
      break if ['h', 'hit', 's', 'stay'].include?(choice)
      puts "That's not a valid option. Type hit or stay (or h/s) only."
    end
    choice
  end

  def play_again?
    choice = nil
    loop do
      puts ""
      puts "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(choice)
      puts "Invalid. Please type yes, no, y, or n"
    end
    choice.start_with?('y')
  end

  def clear_screen
    system 'cls'
    system 'clear'
  end
end

Game.new.start