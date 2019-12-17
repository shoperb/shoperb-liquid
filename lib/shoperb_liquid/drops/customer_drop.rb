# frozen_string_literal: true

module ShoperbLiquid
  class CustomerDrop < Base
    def id
      record&.id
    end

    def name
      record.name
    end

    def first_name
      record.first_name
    end

    def last_name
      record.last_name
    end

    def email
      record.email
    end

    def accepts_newsletter?
      record.newsletter
    end

    def registred?
      record.active?
    end

    def discount_pct
      record.discount_pct
    end

    def last_billing_address
      AddressDrop.new(record.last_bill_address)
    end

    def last_shipping_address
      AddressDrop.new(record.last_ship_address)
    end

    def addresses
      CollectionDrop.new(record.addresses)
    end

    def orders
      CollectionDrop.new(record.orders.sorted)
    end

    def logged_in?
      record && record.id.present?
    end

    def recommended_products
      ProductsDrop.new(record.recommended_products)
    end

    def company?
      record.company?
    end

    def personal?
      !record.company?
    end

    def company_name
      record.company_name
    end

    def vat_number
      record.vat_number
    end
    
    def active_subscriptions
      CollectionDrop.new(record.subscriptions.active)
    end
    
    def custom_fields
      CustomField.where(klass: record.class.to_s.demodulize, customer_see: true).
        each_with_object({}) do |cf,hash|
          hash[cf.handle] = cf.as_json
          hash[cf.handle]["set_values"]   = record.custom_field_values.to_h[cf.handle.to_s]
          hash[cf.handle]["set_values"] ||= cf.default_values if cf.default_values.select(&:present?).present?
          hash[cf.handle]["set_values"] ||= []
      end
    end
  end
end
