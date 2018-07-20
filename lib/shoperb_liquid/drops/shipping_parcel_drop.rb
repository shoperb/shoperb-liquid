# frozen_string_literal: true

module ShoperbLiquid
  class ShippingParcelDrop < Base
    def barcode
      record.barcode
    end

    def number
      record.number
    end

    def state
      record.state
    end

    def order
      record.order.to_liquid
    end

    def shipping_items
      CollectionDrop.new(record.shipping_items)
    end
  end
end
