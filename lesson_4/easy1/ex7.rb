=begin
What is the default return value of to_s when invoked on an object?
Where could you go to find out if you want to be sure?

The default return value of to_s invoked on an object is the object's unique
identifier (<#...object id>)

To find out for sure, you can go to the Object class in ruby documentation.
Or simply call to_s on a custom class' object that lacks a to_s override.

=end