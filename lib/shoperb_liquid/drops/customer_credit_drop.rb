# frozen_string_literal: true

module ShoperbLiquid
  class CustomerCreditDrop < Base

    def id
      record.id
    end

    def amount
      record.amount
    end

    def amount_left
      record.amount_left
    end

    def expires_at
      record.expires_at
    end

  end
end
