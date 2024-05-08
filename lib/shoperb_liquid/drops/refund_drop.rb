# frozen_string_literal: true

module ShoperbLiquid
  class RefundDrop < Base
    def id
      record.id
    end
    def state
      record.state
    end
    def amount
      record.amount
    end
    def reason
      record.reason
    end

    def items
      CollectionDrop.new(record.refund_items)
    end
  end
end
