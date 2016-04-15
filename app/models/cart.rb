class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		product = Product.find(product_id)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.update_attributes(quantity: current_item.quantity + 1)
		else
			current_item = LineItem.new(product_id: product_id, price: product.price)
    		line_items << current_item
		end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

end
