# frozen_string_literal: true

module ShoperbLiquid
  class VendorDrop < Base
    def initialize(record)
      @record = record || Vendor.new
    end

    def id
      record.id
    end

    def handle
      record.handle
    end

    def permalink
      record.permalink
    end

    def name
      record.name
    end

    def description
      record.description
    end

    def code
      record.code
    end

    def fax
      record.fax
    end

    def phone
      record.phone
    end

    def email
      record.email
    end

    def website
      record.website
    end

    def contact_name
      record.contact_name
    end

    def contact_phone
      record.contact_phone
    end

    def contact_email
      record.contact_email
    end

    def image
      ImageDrop.new(record.image) if record.image
    end

    def address
      AddressDrop.new(record.address) if record.address
    end

    def products
      ProductsDrop.new(record.products)
    end

    def url
      controller.store_brand_path(record)
    end
  end
end
