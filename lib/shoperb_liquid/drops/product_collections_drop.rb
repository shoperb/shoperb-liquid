# frozen_string_literal: true

module ShoperbLiquid
  class ProductCollectionsDrop < CollectionDrop
    private

    def collection
      @collection = Collection.all if @collection.empty?
      @collection
    end
  end
end
