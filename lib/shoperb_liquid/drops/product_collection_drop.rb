# frozen_string_literal: true

module ShoperbLiquid
  class ProductCollectionDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.permalink
    end

    def image
      ImageDrop.new(record.image) if record.image
    end

    def url
      controller.store_collection_path(record)
    end

    def description
      record.description
    end

    def products
      ProductsDrop.new(record.products.includes(:variants))
    end

    def vendors
      VendorsDrop.new(record.vendors)
    end
  end
end
