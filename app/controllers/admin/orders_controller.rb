class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
  
  def index
    @orders = Order.all(params[:id])
  end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		p "-------"
		p @order_details
		
		@order.shipping_cost = 800


	end

	def total(items_total_price)

	end

	def update
		@order = Order.find(params[:id])
		@order_details = @order.order_details
    @order.update(order_params)
		redirect_to admin_order_path(@order.id)
	end

  private
	def order_params
		params.require(:order).permit(:status)
	end
end

