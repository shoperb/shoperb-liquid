# frozen_string_literal: true

module ShoperbLiquid
  class VendorsDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = collection || Vendor.all
    end

    def not_empty
      self.class.new(@collection.not_empty)
    end
  end
end
