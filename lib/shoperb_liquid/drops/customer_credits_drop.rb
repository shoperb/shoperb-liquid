# frozen_string_literal: true

module ShoperbLiquid
  class CustomerCreditsDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || CustomerCredit.none)
    end

    def valid
      @collection = @collection.valid
      self
    end

    def total
      @collection.sum(:amount_left)
    end
  end
end
