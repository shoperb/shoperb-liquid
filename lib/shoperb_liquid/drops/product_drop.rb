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
    
    def stock
      sum = 0
      _variants.each do |v|
        return nil if v.stock.nil?
        sum += v.stock
      end
      sum
    end

    def url
      controller.store_product_path(record)
    end

    def url_full
      controller.store_product_url(record, host: shop.domain)
    end

    def reviews_url
      controller.reviews_store_product_path(record)
    end

    def dirty_variant_attributes
      if record.respond_to?(:dirty_variant_attributes) && record.dirty_variant_attributes
       record.dirty_variant_attributes
      else
       record.variants.each_with_object({}) do |v,h|
        v.variant_attributes.each do |va|
          h[va.name] ||= []
          h[va.name]  |= [va.value]
         end
        end
      end
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
      record.grouping_tags
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

    def reviews
      CollectionDrop.new(record.reviews.visible.with_content)
    end

    def reviewable?
      record.reviewable?(current_customer)
    end

    def rating
      record.rating
    end

    private

    def _variants
      record.variants
    end
  end
end
