# Preview all emails at http://localhost:3000/rails/mailers/order_notifier
class OrderNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_notifier/received
  def received
    OrderNotifier.received
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_notifier/shipped
  def shipped
    OrderNotifier.shipped
  end

  def error_occured
  	error = Object.new
  	def error.message
		"hello bitch"
	end
  	OrderNotifier.error_occured(error)
  end

end
