# What not to do with duck typing
# prepare method has too many dependencies: relies on specific classes
# and their names and it needs to know which method it should call on each of
# the objects and the argument that those methods require.

class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_preformance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_preformance(songs)
    # implementation
  end
end