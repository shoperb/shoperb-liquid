# frozen_string_literal: true

module ShoperbLiquid
  class ProductDrop < Base
    def context=(context)
      super(context)
      record.customer = current_customer
    end

    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.permalink
    end

    def url
      controller.store_product_path(record)
    end

    def max_price
      record.maximum_price
    end

    def min_price
      record.minimum_price
    end
    alias_method :price, :min_price

    def min_discount_price
      record.minimum_discount_price
    end

    def max_discount_price
      record.maximum_discount_price
    end

    def min_active_price
      record.minimum_active_price
    end

    def max_active_price
      record.maximum_active_price
    end

    def available?
      _variants.available.exists?
    end

    def description
      record.description
    end

    def options
      record.product_attributes.map(&:value)
    end

    def tags
      record.tags
    end

    def category
      CategoryDrop.new(record.category)
    end

    def vendor
      VendorDrop.new(record.vendor)
    end

    def type
      ProductTypeDrop.new(record.product_type)
    end

    def variants
      VariantsDrop.new(_variants)
    end

    def available_variants
      VariantsDrop.new(_variants.available)
    end

    def image
      ImageDrop.new(record.image) if record.image
    end

    def images
      CollectionDrop.new(record.images.sorted)
    end

    def attributes
      CollectionDrop.new(record.product_attributes)
    end

    def variant_properties
      CollectionDrop.new(record.variant_attributes)
    end

    def similar_products
      ProductsDrop.new(record.similar)
    end

    def others_in_category
      return ProductsDrop.new(Product.none) unless record.category

      ProductsDrop.new(record.category.products_for_self_and_children.where.not(id: record.id))
    end

    private

    def _variants
      record.variants
    end
  end
end
