class PaymentType < ActiveRecord::Base
	has_many :orders

	def self.names
		all.collect { |paytype| paytype.name }
	end
end
