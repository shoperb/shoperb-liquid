# frozen_string_literal: true

module ShoperbLiquid
  class OrderReturnItemEntityDrop < Base
    def id
      record.id
    end

    def customer_comment
      record.customer_comment
    end
  end
end
