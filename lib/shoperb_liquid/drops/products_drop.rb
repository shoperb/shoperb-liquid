# frozen_string_literal: true

module ShoperbLiquid
  class ProductsDrop < CollectionDrop
    def initialize(collection=nil)
      @collection = (collection || Product).active.preload(
        :product_attributes, :variants, images: [:image_sizes]
      )
    end

    def liquid_method_missing(method, *args)
      if matches = method.to_s.match(/(add_)?order_by_(.*)_(asc|desc)/i)
        order = matches[3]
        rel   = collection
        rel   = rel.reorder("") unless matches[1] # remove sort if "add_" not added
        @collection = case matches[2]
                        when "created"
                          rel.by_created(order)
                        when "updated"
                          rel.by_updated(order)
                        when "name"
                          rel.by_name(order)
                        when "price"
                          rel.by_price(order)
                        when "product_type"
                          rel.by_product_type(order)
                        when "tags"
                          rel.by_tags(order)
                        when "handle"
                          rel.by_handle(order)
                        else
                          collection
                      end and self
      else
        super(method)
      end
    end
  end
end
