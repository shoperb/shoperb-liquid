# frozen_string_literal: true

module ShoperbLiquid
  class ShippingItemDrop < Base
    def id
      record.id
    end
    
    def product_name
      record.order_item.product.name
    end

    def order_item
      OrderItemDrop.new(record.order_item)
    end

    def amount
      record.amount
    end

    def shipping_date
      record.created_at
    end
  end
end