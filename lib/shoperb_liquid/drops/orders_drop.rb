# frozen_string_literal: true

module ShoperbLiquid
  class OrdersDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || Order.all)
    end

    def had_subscription
      @collection.had_subscription
    end
  end
end
