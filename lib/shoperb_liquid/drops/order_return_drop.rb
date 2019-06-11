# frozen_string_literal: true

module ShoperbLiquid
  class OrderReturnDrop < Base
    def id
      record.id
    end
    def delivery_date
      record.delivery_date
    end
    def comment
      record.comment
    end
    def state
      record.state
    end
    
    def items
      CollectionDrop.new(record.items.all)
    end
    
    def parcel
      record.return_parcel&.to_liquid
    end
    
    def url
      controller.store_order_return_path(id)
    end
    
    def generate_parcel_url
      controller.store_order_return_generate_parcel_path(id)
    end
  end
end
