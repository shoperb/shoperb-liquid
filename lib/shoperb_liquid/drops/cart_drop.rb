# frozen_string_literal: true

module ShoperbLiquid
  class CartDrop < Base
    def total
      record.customer = current_customer
      record.total
    end

    def weight
      record.weight
    end

    def discount_code
      record.discount_code
    end

    def quantity
      record.items.sum(:amount)
    end

    def requires_shipping?
      record.require_shippable?
    end

    def notes
      record.notes
    end

    def items
      CollectionDrop.new(record.items)
    end
  end
end
