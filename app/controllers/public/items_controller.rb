class Public::ItemsController < ApplicationController

 def top
  @genres = Genre.all
  @items = Item.all
 end

 def index
  @genres = Genre.all
  @items = Item.all
  @quantity = Item.count 
 end

 def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
  @genres = Genre.where(valid_invalid_statue: 0)
 end

 def about
 end
 
end
