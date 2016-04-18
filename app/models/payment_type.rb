class PaymentType < ActiveRecord::Base
	has_many :orders

	# def self.all_localed
	# 	if I18n.locale.to_s == "en"
	# 		all
	# 	else
	# 		a = I18n.locale.to_s + "_name"
	# 		all.collect {|name, es_name| name = es_name}
	# 	end
	# end
end
