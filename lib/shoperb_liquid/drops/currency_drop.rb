# frozen_string_literal: true

module ShoperbLiquid
  class CurrencyDrop < Base
    def name
      record.name
    end

    def code
      record.code
    end

    def symbol
      record.symbol
    end
  end
end
