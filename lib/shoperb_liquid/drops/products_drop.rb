# frozen_string_literal: true

module ShoperbLiquid
  class ProductsDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || Product).active.preload(
        :product_attributes, :variants, images: [:image_sizes]
      )
    end

    def liquid_method_missing(method, *args)
      if matches = method.to_s.match(/order_by_(.*)_(asc|desc)/i)
        @collection = case matches[1]
                        when "created"
                          collection.reorder("").by_created(matches[2])
                        when "updated"
                          collection.reorder("").by_updated(matches[2])
                        when "name"
                          collection.reorder("").by_name(matches[2])
                        when "price"
                          collection.reorder("").by_price(matches[2])
                        when "product_type"
                          collection.reorder("").by_product_type(matches[2])
                        else
                          collection
                      end and self
      else
        super(method)
      end
    end
  end
end
