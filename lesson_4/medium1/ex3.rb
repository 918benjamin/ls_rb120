=begin
In the last question Alan showed Alyssa this code which keeps track of items for
a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

Alyssa noticed that this will fail when update_quantity is called. Since
quantity is an instance variable, it must be accessed with the @quantity
notation when setting it. One way to fix this is to change attr_reader to
attr_accessor and change quantity to self.quantity.

Is there anything wrong with fixing it this way?
If we change to attr_accessor for both @quantity and @product_name, we may
inadvertantly create a setter method for @product_name when we didn't intend to.

LS Solution points out that syntactically there isn't anything wrong with this.
But it does introduce an unintended workaround to changing the @quantity when we
have explicitly included a guard against updating the quantity if it is below 0.
Offering a public accessor method @quantity setter circumvents this protection.

=end

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

entry = InvoiceEntry.new("hammer", 10)
entry.update_quantity(5)
p entry.quantity