# frozen_string_literal: true

module ShoperbLiquid
  class CartItemDrop < Base
    def context=(context)
      super(context)

      @record.cart.customer = current_customer
      @record.variant.customer = current_customer
    rescue Exception => e
      binding.pry
    end

    def id
      record.id
    end

    def sku
      record.sku
    end

    def name
      record.variant.name
    end

    def quantity
      record.amount
    end

    def stock
      record.stock
    end

    def weight
      record.variant.weight
    end

    def price
      record.variant.price
    end

    def discount_price
      record.variant.active_price if record.variant.discount.present?
    end

    def active_price
      record.variant.active_price
    end

    def discount?
      record.variant.discount.present?
    end

    def discount_start
      record.variant.formatted_discount_start
    end

    def discount_end
      record.variant.formatted_discount_end
    end

    def total
      record.total
    end

    def total_weight
      record.weight
    end

    def requires_taxing?
      record.variant.charge_taxes?
    end

    def requires_shipping?
      !digital?
    end

    def digital?
      record.variant.digital?
    end

    def vendor
      VendorDrop.new(record.vendor)
    end

    def type
      ProductTypeDrop.new(record.product.product_type)
    end

    def product
      ProductDrop.new(record.product)
    end

    def variant
      VariantDrop.new(record.variant)
    end
  end
end
