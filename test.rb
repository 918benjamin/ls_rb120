module Armable
  def attach_armor
    # attach the armor
  end

  def remove_armor
    # remove the armor
  end
end

module SpellCastable
  def cast_spell(spell)
    # cast the spell
  end
end

class Player
  def initialize(name)
    @name = name
    @health = 100
    roll_dice
  end

  # It wasn't specfied either way in the instructions, so I made #heal and #hurt public
  # assuming they'd need to be accessed outside the class to function.
  def heal(amount)
    self.health += amount
  end

  def hurt(amount)
    self.health += amount
  end

  def to_s
    "Name: #{name}\n" +
    "Class: #{self.class}\n" +
    "Health: #{health}\n" +
    "Strength: #{strength}\n" +
    "Intelligence: #{intelligence}"
  end

  private

  attr_accessor :health
  attr_reader :name, :strength, :intelligence

  def roll_dice
    @strength = rand(2..12)
    @intelligence = rand(2..12)
  end
end

class Warrior < Player
  include Armable

  def initialize(name)
    super
    @strength += 2
  end
end

class Paladin < Player
  include Armable, SpellCastable
end

class Magician < Player
  include SpellCastable

  def initialize(name)
    super
    @intelligence += 2
  end

  private
end

class Bard < Magician
  def create_potion
    # create a potion
  end
end