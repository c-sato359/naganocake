class OrderDetail < ApplicationRecord

  belongs_to :item, optional: true
  belongs_to :order, optional: true

      enum making_status: { "着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3 }

end
