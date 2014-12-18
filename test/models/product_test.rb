require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "product attributes must not be empty" do 
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?

  end

  test "product price must be positive" do
  	product = Product.new(title: "New Swim Suit",
  												description: "yyyz",
  												image_url: "zzz.jpg")
  	product.price = -1
  	assert product.invalid?
  	asseet_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: "My Swim Suit",
  							description: "zzz",
  							price: 1,
  							image_url: image_url)
  end

  test "image_url" do
  	ok = %w{ fred.jpg fred.gif fred.png FRED.JPG FRED.jpg
  						http://a.b.c/x/y/z/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }
  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} should be valid"
  end
  bad.each do |name|
  	assert new_product(name).invalid?, "#{name} shouldn't be invalid"
  end

  test "product is not valid without a unique title" do
  	product = Product.new(title: products(:ruby).title,
  												description: "Swim Suit by Kes",
  												price: 49.95,
  												image_url: "ruby.png")

  	assert product.invalid?
  	assert_equal ["has already been taken"], product.errors[:title]
    end
  end
end
