class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize
  def index
  	if params[:set_locale]
  		redirect_to store_url(locale: params[:set_locale])
  	else
  		@products = Product.current_locale_products.order(:title)
  	end
  	session[:counter].nil? ? session[:counter] = 1 : session[:counter] += 1 
  end
end
