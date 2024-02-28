# frozen_string_literal: true

module ShoperbLiquid
  class OrderReturnsDrop < CollectionDrop
    def order_by_id_asc
      collection.by_id("asc")
    end

    def order_by_id_desc
      collection.by_id("desc")
    end
  end
end
