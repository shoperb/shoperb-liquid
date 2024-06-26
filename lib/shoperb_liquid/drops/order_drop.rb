# frozen_string_literal: true

module ShoperbLiquid
  class OrderDrop < Base
    def name
      "#" + record.number
    end

    def id
      record.id
    end

    def number
      record.number
    end

    def token
      record.token
    end

    def email
      record.email
    end

    def total
      record.total
    end

    def total_items
      record.total_items
    end

    def total_wo_discount
      record.total_wo_discount
    end

    def taxation_percentage
      record.taxation_percentage
    end

    def subtotal
      record.subtotal
    end

    def subtotal_wo_discount
      record.subtotal_wo_discount
    end

    def total_shipping
      record.total_shipping
    end

    def total_taxes
      record.total_taxes
    end

    def requires_shipping?
      record.require_shipping?
    end

    def requires_taxation?
      record.require_taxation?
    end

    def created_at
      record.created_at
    end

    def state
      record.state
    end

    def notes
      record.notes
    end

    def discount_code
      record.discount_code
    end

    def neto_discount
      record.neto_discount
    end

    def bruto_discount
      record.bruto_discount
    end

    def shipping_method
      record.shipping_method.try(:to_liquid)
    end

    def payment_method
      record.payment_method.try(:to_liquid)
    end

    def payment_method_name
      record.payment_method.name
    end

    def billing_address
      AddressDrop.new(record.bill_address)
    end

    def shipping_address?
      !!record.ship_address
    end

    def shipping_address
      AddressDrop.new(record.ship_address)
    end

    def items
      CollectionDrop.new(record.items)
    end

    def shipping_items
      CollectionDrop.new(record.shipping_items)
    end

    def refunds
      CollectionDrop.new(record.refunds)
    end

    def customer
      CustomerDrop.new(record.customer)
    end

    def currency
      CurrencyDrop.new(record.currency)
    end

    def url
      controller.store_order_path(number)
    end

    def payment_url
      unless record.payment_method.succeed?
        routes.store_checkout_order_url(
          id: record.checkout.token,
          state: :payment,
          host: shop.domain
        )
      end
    end

  end
end
