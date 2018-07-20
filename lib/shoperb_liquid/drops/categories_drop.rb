# frozen_string_literal: true

module ShoperbLiquid
  class CategoriesDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || Category).active
    end

    def roots
      CategoriesDrop.new(Category.roots.active)
    end
  end
end
