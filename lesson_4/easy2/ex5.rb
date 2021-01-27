=begin
There are a number of variables listed below.
What are the different types and how do you know which is which?

excited_dog = "excited dog"
local variable, because there's nothing else it can be. If we wanted this to
represent a setter method excited_dog=, we'd need to invoke self.excited_dog
due to lack of @ and lack of self. prefix

@excited_dog = "excited dog"
Either an instance variable if initialized within an instance method, or a
class instance variable (which we haven't covered yet) if initialized outside
an instance method. Due to the @ prefix

@@excited_dog = "excited dog"
class variable due to the double @@ prefix

=end