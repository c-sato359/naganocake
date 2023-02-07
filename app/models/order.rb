class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waitig: 0, confirmation: 1, making: 2, preparing: 3, sent: 4 }
end
