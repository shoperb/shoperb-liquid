# frozen_string_literal: true

module ShoperbLiquid
  class RefundItemDrop < Base
    def id
      record.id
    end
    def count
      record.count
    end
    def order_item_id
      record.order_item_id
    end
    def order_item
      OrderDrop.new(record.order_item)
    end
  end
end
