class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = item.all
  end
  def show
    @item = Item.find(params[:id])
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      redirect_to item_path(@item.id)
    else
      @items = Item.all
      render :index
    end
  end
end