=begin
If I have the following Television class, what would happen if I called the
methods like shown below?




=end

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # => NoMethodError - no instance method called manufacturer (it's a class method)
tv.model # => no issue

Television.manufacturer # => no issue
Television.model # => NoMethodError - no class method called model (it's an instance method)