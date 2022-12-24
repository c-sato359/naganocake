class Public::CartItemsController < ApplicationController
	def create
		binding.pry
	end
  
private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
