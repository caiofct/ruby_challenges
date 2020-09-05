# Given an array of strings:
#
# "productName, PopularityScoreAsaStringOutOf100, and priceIntegerAsaString"
#
# how would you rank the items by popularity.
# If there is a tie with pop score, place the cheaper priced item first.

class Product
  include Comparable
  attr_reader :name, :popularity, :price

  def initialize(name:, popularity:, price:)
    @name = name
    @popularity = popularity.to_i
    @price = price.to_i
  end

  def <=>(other)
    if popularity == other.popularity
      return other.price <=> price
    end

    popularity <=> other.popularity
  end

  def to_s
    "#{name}, #{popularity}, #{price}"
  end
end

require 'forwardable'

class ProductList
  extend Forwardable

  attr_reader :products

  def_delegator :@products, :sort

  def initialize(products)
    @products = products
    parse
  end

  def to_s
    products.map(&:to_s).join("\n")
  end

  private

  def parse
    @products = products.map do |product|
      name, popularity, price = product.split(',')
      Product.new(name: name, popularity: popularity, price: price)
    end
  end
end

productStringArray = ["Product 1,65,10", "Product 2,33,25", "Product 3,65,8", "Product 4,87,45"]

productList = ProductList.new(productStringArray)
puts "Sorted Products: #{productList.sort.reverse.map(&:to_s)}"
puts "Original Products:\n#{productList.to_s}"
