# frozen_string_literal: true

module ShoperbLiquid
  class AccountDrop < Base
    def shops
      CollectionDrop.new(@record.shops.by_name)
    end
  end
end
