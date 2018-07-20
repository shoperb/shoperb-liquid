# frozen_string_literal: true

module ShoperbLiquid
  class ThemeSectionBlocksDrop < CollectionDrop
    def initialize(collection=nil, order=nil)
      @collection = (collection || []).select do |id, block|
        order.include?(id)
      end

      @order = order || []
    end

    def each
      @order.each do |id|
        yield ThemeSectionDrop.new(id, collection[id])
      end
    end
  end
end
