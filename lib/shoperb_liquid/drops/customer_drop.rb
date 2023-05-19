# frozen_string_literal: true

module ShoperbLiquid
  class CustomerDrop < Base
    def id
      record&.id
    end

    def name
      record&.name
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
      OrdersDrop.new(record.orders.sorted)
    end

    def customer_credits
      CustomerCreditsDrop.new(record.orders.sorted)
    end

    def logged_in?
      record && record.id.present?
    end

    def recommended_products
      ProductsDrop.new(record.recommended_products)
    end

    def customer_groups
      record.customer_groups
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

    def existing_order_returns
      record.existing_order_returns
    end

    # returns a hash with order id and order with not returned items
    def new_order_returns
      record.new_order_returns
    end

    def order_returns
      puts "Deprecation Note: Please use new_order_returns method"
      record.new_order_returns
    end

    # @retturn Integer number of items user hasn't returned
    def not_returned_items
      record.not_returned_items
    end

    def active_subscriptions
      CollectionDrop.new(record.subscriptions.active)
    end
  end
end
