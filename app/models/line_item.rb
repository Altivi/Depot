class LineItem < ActiveRecord::Base
  	belongs_to :order
  	belongs_to :product
  	belongs_to :cart

  	def total_price
		product.price * quantity
	end

	def decrement
		self.quantity > 1 ? (self.quantity -= 1) : self.destroy
	end

end