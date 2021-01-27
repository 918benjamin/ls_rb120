=begin
How do you find where Ruby will look for a method when that method is called?
You check the method lookup path by invoking the ancestors method on the class

How can you find an object's ancestors?
Invoke the ancestors method on the object's class

What is the lookup chain for Orange and HotSauce?
Orange => [Orange, Taste (module), Object, Kernel (module), BasicObject]
HotSauce => [HotSauce, Taste (module), Object, Kernel (module), BasicObject]

=end

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors