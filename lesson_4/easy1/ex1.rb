=begin
Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

1. true
2. "hello"
3. [1, 2, 3, "happy days"]
4. 142

All four are objects
1. Boolean object of TrueClass
2. String object
3. Array object
4. Integer object

Can determine which classs they belong to by invoking the #class instance method
on any of them
=end

p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class