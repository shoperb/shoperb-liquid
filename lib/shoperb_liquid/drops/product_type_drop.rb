# frozen_string_literal: true

module ShoperbLiquid
  class ProductTypeDrop < Base
    def initialize(record)
      @record = record || ProductType.new
    end

    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def products
      ProductsDrop.new(record.products.includes(:variants))
    end
  end
end
