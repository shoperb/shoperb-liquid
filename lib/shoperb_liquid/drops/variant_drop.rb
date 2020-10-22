# frozen_string_literal: true

module ShoperbLiquid
  class VariantDrop < Base
    def context=(context)
      super(context)
      @record.customer = current_customer
    end

    def id
      record.id
    end

    def name
      record.name
    end

    def price
      record.price
    end

    def discount_price
      # active price includes discount
      record.active_price if discount?
    end

    def discount?
      record.discount.present?
    end

    def discount_period?
      record.has_discount_range?
    end

    def discount_start
      record.formatted_discount_start
    end

    def discount_end
      record.formatted_discount_end
    end

    def current_price
      record.active_price
    end

    def compare_at
      record.compare_at
    end
    def market_price
      record.compare_at
    end
    def gift_card_value
      record.gift_card_value
    end

    def available?
      record.available?(:warehouse)
    end

    def purchased?
      if current_customer
        current_customer.purchased_variant?(record)
      else
        false
      end
    end

    def sku
      record.sku
    end

    def stock
      record.track_inventory? ? record.stock(Cart.new) : nil
    end

    def weight
      record.weight
    end

    def width
      record.width
    end

    def height
      record.height
    end

    def depth
      record.depth
    end

    def digital
      record.digital
    end

    def url
      record.url
    end

    def options
      record.variant_attributes.map(&:value)
    end

    def image
      ImageDrop.new(record.image) if record.image
    end

    def images
      CollectionDrop.new(record.images.sorted)
    end

    def attributes
      CollectionDrop.new(record.variant_attributes)
    end

    def json
      h = record.as_json(only: [:id, :sku, :name, :weight, :width, :height, :depth, :price])
      h[:gift_card_value] if record.gift_card_value
      h.merge!(
        current_price: current_price,
        has_discount: discount?,
        discount_price: discount_price,
        stock: stock
      )

      record.variant_attributes.each do |attr|
        (h[:attributes] ||= []) << {
          id:     attr.id,
          name:   attr.name,
          value:  attr.value,
          handle: attr.handle,
        }
      end

      h.to_json
    end

    def cached_json
      cache_key = ["liquid.drop", "variant_drop_json", record.cache_key]
      ShoperbLiquid.config.cache.fetch(cache_key) { json }
    end


    def as_json
      {
        id:id,
        product_id: record.product_id,
        sku: sku,
        weight: weight,
        width: width,
        height: height,
        depth: depth,
        price: price,
        gift_card_value: gift_card_value,
        stock: stock,
        discount_price: discount_price,
        discount: discount?,
        current_price: current_price,
        compare_at: compare_at,
        available: available?,
        digital: digital,
        url: url,
        image: image&.url
      }
    end
  end
end
