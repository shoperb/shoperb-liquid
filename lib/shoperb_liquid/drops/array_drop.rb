# frozen_string_literal: true

module ShoperbLiquid
  class ArrayDrop < CollectionDrop
    def [](attr)
      return super unless attr.is_a?(Integer)
      collection[attr]
    end

    def include?(other)
      collection.include?(other)
    end

    def inspect
      collection.inspect
    end
  end
end
