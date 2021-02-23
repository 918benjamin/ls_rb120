require "pry"
require "pry-byebug"

class Participant
  BUST_NUMBER = 21

  attr_accessor :name, :hand, :stay

  def initialize
    @hand = []
    @stay = false
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
    'Ace' => [11, 1] # gonna be a problem
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

  # def to_s
    # "#{rank} of #{suit}"
  # end

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
  end

  def start
    assign_names
    display_welcome_message
    # Some kind of 'next' before dealing the hand?
    loop do
      play_round
      determine_winner
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :player, :dealer, :deck

  def play_round
      reset_and_shuffle
      deal
      player_turn
      return if player.busted? # TODO: pass something from this method to trigger busted message?
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
         "is less than #{Dealer::HIT_UNDER}."
    puts "- Whoever has the closest to 21 without busting, wins."
  end

  def reset_and_shuffle
    self.deck = Deck.new
    # TODO: will need to reset scores and player.stay and dealer.stay == false
  end

  def deal
    2.times do
      player.hand << deck.draw
      dealer.hand << deck.draw 
    end
  end

  def player_turn
    # clear_screen
    loop do
      display_hands
      hit_or_stay
      break if player.stay || player.busted?
    end
  end

  def display_hands
    # TODO: dry this up and adapt it to work for both during gameplay and
          # displaying results (both full hands)
    puts ""
    puts "---Current hands---"
    puts "#{dealer.name}: #{dealer.hand[0].rank} of #{dealer.hand[0].suit}"\
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
    puts "You stayed."
    player.stay = true
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

  def clear_screen
    system 'cls'
    system 'clear'
  end
end

Game.new.start