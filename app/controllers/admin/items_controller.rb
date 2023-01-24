class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!,only:
  [:create, :edit, :update, :index, :show, :new]

  def index
    @item = Item.new
    @items = Item.all
  end
  def show
    @item = Item.find(params[:id])
  end
  def new
    @item = Item.new
    
   # if @item.save
    #  flash[:notice] = "You have created item successfully."
     # redirect_to new_admin_item_path(@item.id)
  #  else
   #   flash[:genre_created_error] = "ジャンル名を入力してください"
#      @items = Item.all
#      render :index
  #  end
  end
  def create
    @item = Item.new(item_params)
   # @genres = Genre.all
    if @item.save
   #   flash[:notice] = "You have created item successfully."
      redirect_to admin_item_path(@item)
    else
      #flash[:genre_created_error] = "ジャンル名を入力してください"
      @items = Item.all
      render "index"
      
    end
  end

  def edit
  	@item = Item.find(params[:id])
  end

  def update
  	@item = Item.find(params[:id])
  	if @item.update(item_params)
  	  redirect_to admin_item_path(@item.id)
  	else
  		render "edit"
  	end
  end

  private

  def item_params
  	params.require(:item).permit(:genre_id,:item_name,:unit_price_without_tax,:sale_status,:explanation,:image,:name,:introduction,:price,:is_active)
  end

end