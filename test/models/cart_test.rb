require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  test "unique products" do
  	cart = Cart.create
  	cart.add_product(products(:ruby).id)
  	assert_equal 1, cart.line_items.count
  	cart.add_product(products(:rtp).id)
  	assert_equal 2, cart.line_items.count
  end

  test "duplicate products" do
  	cart = Cart.create
  	cart.add_product(products(:ruby).id)
  	assert_equal 1, cart.line_items.count
  	assert_equal 1, cart.line_items.find_by_product_id(products(:ruby).id).quantity, "cart line item quantity is incorrect"
  	cart.add_product(products(:ruby).id)
  	assert_equal 1, cart.line_items.count
  	assert_equal 2, cart.line_items.find_by_product_id(products(:ruby).id).quantity, "cart line item quantity is incorrect"

  end

end
