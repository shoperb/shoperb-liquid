# frozen_string_literal: true

module ShoperbLiquid
  class ProductTypesDrop < CollectionDrop
    private

    def collection
      @collection = ProductType.all if @collection.empty?
      @collection
    end
  end
end



