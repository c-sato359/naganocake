class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one :cart, dependent: :destroy
  has_one :purchase_record, dependent: :destroy
  
    def prepare_cart
      cart || create_cart
    end

    def prepare_order_record
      order_record || create_order_record
    end

    def checkout
      transaction do
        cart_products = cart.cart_products.where(product_id: product_ids)
        cart_products.each(&:destroy!)
      end
        order_record = prepare_order_record
        ids = item_ids.map{ |id| { item_id: id } }
        order_record.order_record_items.create!(ids)
    end
end
