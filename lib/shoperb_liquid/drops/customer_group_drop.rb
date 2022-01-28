# frozen_string_literal: true

module ShoperbLiquid
  class CustomerGroupDrop < Base
    def id
      record&.id
    end

    def name
      record&.name
    end

    def handle
      record.handle
    end
  end
end
