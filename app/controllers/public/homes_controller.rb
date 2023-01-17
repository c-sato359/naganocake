class Public::HomesController < ApplicationController

 def top
  @genres = Genre.where(valid_invalid_statue: 0)
  @items = Item.limit(8).offset(4)
 end
 def about
 end
end
