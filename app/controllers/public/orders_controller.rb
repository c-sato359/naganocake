class Public::OrdersController < ApplicationController
    #before_action :authenticate_admin!
  def new
    @order = Order.new
    @orders =current_customer.orders
    @customer = current_customer
    @cart_items = current_customer.cart_items #メソッド処理を行う為NEWにも記載する
    @address = Address.new
  end

  def payment_method
    card = Card.where(customer_id: current_customer.id).first
    Payjp.api_key = Rails.application.credentials.pay.jp[:PAYJP_PRIVATE]
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id,
    :currency => 'jpy',
    )
  end
  def create
    @order = Order.new(order_params)
		@order.save
  	@customer = current_customer
   	@cart_items = current_customer.cart_items
     sum = 0
		@cart_items.each do |cart_item|
			sum += (cart_item.item.price * 1.1).floor * cart_item.amount
		end
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order
    #@order_deteil.item_id = cart_item.item,id
   #@order_detail.amount = @cart_items.amount
    @order_detail.making_status = 0
    #@order_detail.price = (cart_item.item.price*1.1).floor
    @order_detail.save

    @cart_items.destroy_all
    redirect_to public_orders_thanks_path

  end

  def show
    # 注文内容の情報を取得しています！
  	@order = Order.find(params[:id])
    # 注文内容の商品を取得しています！
  	@order_detail = @order.cart_items
  end

  def complete
   # @order = Order.new(order_params)
  #  order.save
    #@cart_items = current_customer.cart_items #メソッド処理を行う為NEWにも記載する
   # cart_items.each do |cart_item|
    #  order_detail = OrderDetail.new
     # order_detail.order_id = order.id
      #order_deteil.item_id = cart_item.item,id
      #order_detail.amount = cart_item.amount
      #order_detail.making_status = 0
      #order_detail.price = (cart_item.item.price*1.1).floor
     # order_detail.save
    #end
    #cart_items.destroy_all
  end

 def  confirm
      	@cart_items = current_customer.cart_items

   @order = Order.new(order_params)
   @order.postal_code = current_customer.postal_code
   @order.address = current_customer.address
   @order.name = current_customer.last_name+current_customer.first_name
   @total_price = @cart_items.sum do |cart_item|
            (cart_item.item.price * cart_item.amount * 1.1).floor
   end

 end
 def thanks
 end

  def index
     @orders =current_customer.orders
     @path = Rails.application.routes.recognize_path(request.referer)
    if @path[:controller] == "admin/customers" && @path[:action] == "show"
    elsif @path[:controller] == "public/orders"
    end
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new
    @order_detail.order_id = order.id
    @order_deteil.item_id = cart_item.item,id
    @order_detail.amount = cart_item.amount
    @order_detail.making_status = 0
    @order_detail.price = (cart_item.item.price*1.1).floor
    end
  end

  def update
  	@order = Order.find(params[:id]) #注文詳細の特定
  	@order_items = @order.order_items #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新
   	if @order.order_status == "入金確認" #注文ステータスが入金確認なら下の事をする
	     @order_items.update_all(making_status: 1) #製作ステータスを「製作待ちに」更新
  	end
  		 redirect_to  admin_order_path(@order) #注文詳細に遷移
  end

  private

  def order_params
  	params.require(:order).permit(:order_status, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end
end
