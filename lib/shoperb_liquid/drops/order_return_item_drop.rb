# frozen_string_literal: true

module ShoperbLiquid
  class OrderReturnItemDrop < Base
    def id
      record.id
    end
    def order_item
      OrderItemDrop.new(record.order_item)
    end
    def quantity_sent
      try_int(record.quantity_sent)
    end
    def quantity_received
      try_int(record.quantity_received)
    end
    def quantity_requested
      try_int(record.quantity_requested)
    end
  end
end
