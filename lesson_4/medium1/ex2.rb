=begin
Alan created the following code to keep track of items for a shopping cart
application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

Alyssa looked at the code and spotted a mistake.
"This will fail when update_quantity is called", she says.

Can you spot the mistake and how to address it?

qualtity = updated_count won't change the @quantity instance variable because
it looks to ruby like local variable initialization. We need to invoke quantity=
on self.

Oops. I was wrong.

We have no setter method. We need to create a setter method or use @quantity

=end

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

entry = InvoiceEntry.new("hammer", 10)
entry.update_quantity(5)
p entry.quantity