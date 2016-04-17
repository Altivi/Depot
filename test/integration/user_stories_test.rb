require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  	
	test "buying a product" do
	  	LineItem.delete_all
		Order.delete_all
		ruby_book = products(:ruby)
		get "/"
		assert_response :success
		assert_template "index"
		xml_http_request :post, '/line_items', product_id: ruby_book.id
		assert_response :success
		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product
		get "/orders/new"
		assert_response :success
		assert_template "new"
		ship_date_expected = Time.now.to_date   ### new line
		post_via_redirect "/orders",
			order: { name: "Dave Thomas",
					address: "123 The Street",
					email: "dave@example.org",
					payment_type_id: 1,
					ship_date: ship_date_expected }
		assert_response :success
		assert_template "index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size
		orders = Order.all
		assert_equal 1, orders.size
		order = orders[0]

		assert_equal "Dave Thomas", order.name
		assert_equal "123 The Street", order.address
		assert_equal "dave@example.org", order.email
		assert_equal 1, order.payment_type_id
		assert_equal ship_date_expected, order.ship_date  ### new line

		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal ruby_book, line_item.product

		mail = ActionMailer::Base.deliveries.last
		assert_equal ["dave@example.org"], mail.to
		assert_equal 'from@example.com', mail[:from].value
		assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject
	end

	test "should mail the admin when error occurs" do
	    user = users(:one)
	 	get "/login"
	 	assert_response :success
	 	post_via_redirect "/login", name: user.name, password: 'secret'
	 	assert_response :success

	    get "/carts/wibble" 
	    assert_response :redirect

	    mail = ActionMailer::Base.deliveries.last
	    assert_equal ["altivi.prog@gmail.com"], mail.to  ## replace mail id
	    assert_equal "from@example.com", mail[:from].value  ## replace contact name/mail id
	    assert_equal "Depot App Error Incident", mail.subject
	 end

	 test "should fail on access of sensitive data" do
	 	user = users(:one)
	 	get "/login"
	 	assert_response :success
	 	post_via_redirect "/login", name: user.name, password: 'secret'
	 	assert_response :success
	 	assert_equal '/admin', path

	 	get "/carts/12345"
	 	assert_response :success
	 	assert_equal '/carts/12345', path 

	 	delete "/logout"
	 	assert_response :redirect
	 	follow_redirect!
	 	assert_template "/"

	 	get "/carts/12345"
	 	assert_response :redirect
	 	follow_redirect!
	 	assert_equal '/login', path

	 end

	 test "should logout and not be allowed back in" do
	 	delete "/logout"
	 	assert_redirected_to store_url

	 	get "/users"
	 	assert_redirected_to login_url
	 end

end