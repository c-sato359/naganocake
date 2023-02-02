class Item < ApplicationRecord
	belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :image
  validates :name, {presence: true}

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [100, 100]).processed
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
end