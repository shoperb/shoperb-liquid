# frozen_string_literal: true

module ShoperbLiquid
  class OrderItemDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def quantity
      record.amount
    end

    alias_method :qty, :quantity

    def sku
      record.sku
    end

    def attributes
      CollectionDrop.new(record.item_attributes)
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

    def price
      record.price
    end

    def subtotal
      record.total_without_taxes
    end

    def total
      record.total_wout_correlation
    end

    def total_weight
      record.total_weight
    end

    def total_taxes
      record.total_taxes
    end

    def requires_shipping?
      !digital?
    end

    def digital?
      record.digital?
    end

    def by_subscription?
      record.by_subscription
    end

    def item_original_id
      record.item_original_id
    end

    def money_was_repaid?
      OrderItem.where(item_original_id: record.id).exists?
    end

    def url
      record.url
    end

    def download_url
      record.download_url
    end

    def requires_taxation?
      record.charge_taxes?
    end

    def category
      record.category&.name
    end

    def product_id
      record.product_id
    end

    def variant_id
      record.variant_id
    end

    def product_name
      record.product&.name
    end

    def product_url
      ProductDrop.new(record.product).url
    end

    def product_url_full
      ProductDrop.new(record.product).url_full
    end

    def image
      variant_image || images.first
    end

    def variant_image
      ImageDrop.new(record.variant.image) if record.variant && record.variant.image
    end

    def images
      if pr = record.product
        CollectionDrop.new(pr.images.sorted)
      else
        []
      end
    end
  end
end
