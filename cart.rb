class Cart
  attr_reader :line_items

  Item = Struct.new(:id, :name, :quantity, :price, keyword_init: true) do
    def ==(item)
      return true if item.id == id

      false
    end

    def to_s
      "\tItem ##{id}: #{name} - Quantity: #{quantity} Price: #{price}\n"
    end
  end

  def initialize(line_items:)
    @line_items = line_items
  end

  def add(item:)
    found_item = line_items.find{|line_item| line_item == item}
    if found_item
      found_item.quantity += item.quantity
    else
      line_items.push item
    end
  end

  def remove(id:)
    line_items.delete_if{|item| item.id == id}
  end

  def set_quantity(id:, quantity:)
    found_item = line_items.find{|item| item.id == id}
    return unless found_item

    found_item.quantity = quantity
  end

  def total
    line_items.reduce(0) {|sum, item| sum + item.quantity * item.price }.round(2)
  end

  def to_s
    puts "Cart has the following items: \n"
    line_items.each do |item|
      puts item
    end
  end
end

line_items = [
  Cart::Item.new(id: 1, name: 'Product 1', price: 10.99, quantity: 2),
  Cart::Item.new(id: 2, name: 'Product 2', price: 57.75, quantity: 4),
  Cart::Item.new(id: 3, name: 'Product 3', price: 99.99, quantity: 3)
]

cart = Cart.new(line_items: line_items)

puts "Cart Total: #{cart.total}"

cart.add(item: Cart::Item.new(id: 4, name: 'Product 4', price: 178.89, quantity: 1) )

puts "Cart Total after adding: #{cart.total}"

cart.add(item: Cart::Item.new(id: 1, name: 'Product 1', price: 10.99, quantity: 1) )

puts "Cart Total after adding existing: #{cart.total}"

cart.remove(id: 2)

puts "Cart Total after removing: #{cart.total}"

cart.set_quantity(id: 4, quantity: 5)

puts "Cart Total after setting quantity: #{cart.total}"

puts "Cart #{cart}"
