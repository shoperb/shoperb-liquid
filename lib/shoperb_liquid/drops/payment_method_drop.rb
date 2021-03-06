# frozen_string_literal: true

module ShoperbLiquid
  class PaymentMethodDrop < Base
    def name
      record.name
    end

    def display_name
      record.display_name
    end

    def provider
      record.name
    end

    def state
      record.state
    end

    def invoice_instructions
      record.payment_method.invoice_instructions
    end

    def checkout_instructions
      record.payment_method.instructions
    end

    def bank_account
      record.payment_method.bank_account
    end

    def bank_name
      record.payment_method.bank_name
    end

    def bic_swift_code
      record.payment_method.bic_swift_code
    end
  end
end
