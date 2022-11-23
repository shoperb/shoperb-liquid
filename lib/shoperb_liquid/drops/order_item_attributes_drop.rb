# frozen_string_literal: true
module ShoperbLiquid
  class OrderItemAttributesDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || OrderItemAttribute.none)
    end

    def from_variant
      @collection = @collection.from_variant
      self
    end

    def from_product
      @collection = @collection.from_product
      self
    end

  end
end
