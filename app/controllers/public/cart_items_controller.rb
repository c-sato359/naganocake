class Public::CartItemsController < ApplicationController
    # カート商品一覧を表示
   before_action :authenticate_customer!
    def index
        @cart_items = current_customer.cart_items
        @total_price = @cart_items.sum do |cart_item|
            cart_item.item.price * cart_item.amount * 1.1
        end
        # sumメソッド：合計金額を出す
        # 1行目の@cart_itemsにsumメソッドを用いて{}の||ブロック変数にcart_itemを代入している。(each do || end の文章と同じイメージ)
        # cart_item.item.price_without_tax：アソシエーションしているのでドットでつなげる。
        # 『このcart_itemのitemのprice_without_tax』 → 『このカート商品の商品（単体）の税抜き価格』
        # cart_item.quantity：『このカート商品の個数』
    end

    def new
       @cart_items = current_customer.cart_items #メソッド処理を行う為NEWにも記載する
       @cart_item = CartItem.new(cart_item_params)
       @cart_item.customer_id = current_customer.id
       @cart_item.item_id = params[:item_id]
    end
    # カート商品を追加する
    def create
        
        if current_customer.cart_items.find_by(item_id: params[:item_id])#カートの中に一致するものがあるか
        @cart_item = CartItem.find_by(item_id: params[:item_id])#  存在した場合にその商品について変数を置く
        @cart_item.amount += params[:cart_item][:amount].to_i
            

           flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
        else
            
        @cart_items = current_customer.cart_items
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = params[:item_id]
           # flash[:alert] = "個数を選択してください"
            #@item = Item.find(params[:item_id])
            #@genres = Genre.where(valid_invalid_statue: 0)
            #render "public/items/show"
        end
        @cart_item.save!
        redirect_to public_cart_items_path

    end

    # 削除や個数を変更した際、カート商品を再計算する
    def update
        @cart_item = CartItem.find(params[:id])
        #@cart.units += cart_params[:units].to_i
        @cart_item.update(cart_item_params)
        redirect_to public_cart_items_path
    end

    # カート商品を一つのみ削除
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
        redirect_to public_cart_items_path
    end

    # カート商品を空ににする
    def all_destroy
        @cart_item = current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert] = "カートの商品を全て削除しました"
        redirect_to public_cart_items_path
    end

    private

      def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id, :customer_id)
      end
end
