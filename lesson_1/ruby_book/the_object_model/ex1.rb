# How do we create an object in Ruby?
# We create an object by instantiated an instance of a class. This can be done
# using the ClassName.new method.

# Give an example of the creation of an object
hsh = Hash.new
p hsh

class GoodBoy
end

boy = GoodBoy.new
p boy
p boy.class


# LS Solution:
# We create an object by defining a class and instantiating it by using the 
# .new method to create an instance, also known as an object.

class MyClass
end

my_obj = MyClass.new
