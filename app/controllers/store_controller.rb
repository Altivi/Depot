class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize
  def index
  	@products = Product.order(:title)
  	session[:counter].nil? ? session[:counter] = 1 : session[:counter] += 1 
  end
end
