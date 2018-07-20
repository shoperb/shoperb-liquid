# frozen_string_literal: true

module ShoperbLiquid
  class AttributeDrop < Base
    def id
      record.id
    end

    def handle
      record.handle
    end

    def name
      record.name
    end

    def value
      record.value
    end
  end
end
