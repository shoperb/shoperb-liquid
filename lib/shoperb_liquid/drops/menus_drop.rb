# frozen_string_literal: true

module ShoperbLiquid
  class MenusDrop < CollectionDrop
    def links
      CollectionDrop.new(Link.all)
    end

    private

    def collection
      @collection = Menu.all if @collection.empty?
      @collection
    end
  end
end
