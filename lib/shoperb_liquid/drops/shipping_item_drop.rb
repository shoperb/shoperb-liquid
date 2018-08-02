# frozen_string_literal: true

module ShoperbLiquid
  class ShippingItemDrop < Base
    def product_name
      record.order_item.product.name
    end

    def order_item
      OrderItemDrop.new(record.order_item)
    end

    def amount
      record.amount
    end
  end
end