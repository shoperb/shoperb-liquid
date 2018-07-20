# frozen_string_literal: true

module ShoperbLiquid
  class PagesDrop < CollectionDrop
    private

    def collection
      @collection = Page.all if @collection.empty?
      @collection
    end
  end
end
