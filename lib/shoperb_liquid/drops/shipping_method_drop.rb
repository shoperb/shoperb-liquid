# frozen_string_literal: true

module ShoperbLiquid
  class ShippingMethodDrop < Base
    def name
      record.name
    end

    def rate
      record.rate
    end

    def provider
      record.provider
    end

    def provider_box
      record.provider_box
    end

    def tracking_number
      record.tracking_number
    end
  end
end
