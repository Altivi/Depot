class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  protected

  	def authorize
  		return if User.count.zero?

		unless User.find_by(id: session[:user_id])
			case request.format 
			when Mime::HTML
				redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
			else
			 	authenticate_or_request_with_http_basic do |username, password|
			 		user = User.find_by_name(username)
			 		if user and user.authenticate(password)
				       session[:user_id] = user.id
				    end
			 	end
			end
		end
	end
end
