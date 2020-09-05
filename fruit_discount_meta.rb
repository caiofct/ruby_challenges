# peach -> $5 each basket
# apple -> $2 each basket
# banana -> $3 each basket
#
# Discount rules
#
# For Peaches: Buy 2 get 1 free
# For Apples: Buying 2 or more and get 20% discount
# Build a checkout system to receive an array like this one and return the total
# amount:
#
# [['peach', 3],['apple', 2], ['banana', 4]] => $25.2

class Peach
  VALUE = 5

  attr_reader :quantity

  def initialize(quantity)
    @quantity = quantity
  end

  def total
    remaining = quantity % 2
    ((quantity - remaining) / 2 * VALUE) + (remaining * VALUE)
  end
end

class Apple
  VALUE = 2

  attr_reader :quantity

  def initialize(quantity)
    @quantity = quantity
  end

  def total
    if quantity < 2
      return quantity * VALUE
    end

    quantity * VALUE * 0.8
  end
end

class Banana
  VALUE = 3

  attr_reader :quantity

  def initialize(quantity)
    @quantity = quantity
  end

  def total
    quantity * VALUE
  end
end

class FruitFactory
  def self.build(fruit_data)
    fruit_name = fruit_data[0].capitalize
    quantity = fruit_data[1]

    # Using metaprogramming here to avoid using a when...case expression for
    # each class
    Object.const_get(fruit_name).new(quantity)
  end
end

class Checkout
  attr_reader :items

  def initialize(items)
    @items = items
    build
  end

  def build
    @items =
      items.map do |fruit_data|
        FruitFactory.build(fruit_data)
      end
  end

  def grand_total
    @items.reduce(0) do |sum, item|
      sum + item.total
    end
  end
end

items = [['peach', 3],['apple', 2], ['banana', 4]]
checkout = Checkout.new(items)
puts "TOTAL: #{checkout.grand_total}"

items = [['peach', 2],['apple', 1], ['banana', 1]]
checkout = Checkout.new(items)
puts "TOTAL: #{checkout.grand_total}"

items = [['peach', 0],['apple', 0], ['banana', 0]]
checkout = Checkout.new(items)
puts "TOTAL: #{checkout.grand_total}"
