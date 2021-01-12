=begin
Given the following code...

bob = Person.new
bob.hi

And the corresponding error message...

NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?
The problem is that the instance method `hi` is private and inaccessible outside
the class. We can fix this my moving the method definition for `hi` within
the class before the `private` method invocation.

Another way to do this is to create a public `hi` method that calls the 
private `hi` method but obscures the sensitive information in some way.
Similar to our example earlier about the SSN being private but viewable
as a hidden value with just the last 4 digits exposed.

=end