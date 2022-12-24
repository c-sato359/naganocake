class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_record_items, dependent: :destroy
  has_many :items, through: :order_record_items
end
