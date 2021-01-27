=begin
Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

Alyssa glanced over the code quickly and said - "It looks fine, except that you
forgot to put the @ before balance when you refer to the balance instance
variable in the body of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

Who is right, Ben or Alyssa, and why?
Ben is right. You don't need an @ before balance because in this case, balance
is a method call to the getter method for @balance and invoking balance returns
@balance. If this were a += or other assignment, you'd need @ or would need to define
a setter method and invoke it on self.

=end


class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

account = BankAccount.new(1500)
p account.positive_balance?