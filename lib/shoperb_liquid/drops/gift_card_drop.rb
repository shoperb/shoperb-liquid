# frozen_string_literal: true

module ShoperbLiquid
  class GiftCardDrop < Base

    def id
      record.id
    end

    def code
      record.code
    end

    def status
      record.status
    end

    def expires_at
      record.expires_at
    end

    def amount
      record.amount
    end

    def amount_left
      record.amount_left
    end

    def owner_email
      record.owner_email
    end
  end
end
