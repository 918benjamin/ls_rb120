=begin

What is the method lookup path and how is it important?

The method lookup path is the order in which classes and modules are checked
to determine which should be used. Ruby starts at the current class, then any
mixed in modules from the last mixed in module, then the current classes
superclass, then any mixed in modules to that superclass, and so on.

Method lookup path is important because we need to have a clear order for determining
which method is being invoked when classes inherit methods and multiple methods
or versions of the same method share a name (polymorphism)

=end
