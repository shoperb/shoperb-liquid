# frozen_string_literal: true
require_relative 'attribute_drop'

module ShoperbLiquid
  class ProductAttributeDrop < AttributeDrop
    def values
      record.values
    end

    def value
      record.values.join("; ")
    end
  end
end
