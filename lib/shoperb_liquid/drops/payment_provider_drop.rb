# frozen_string_literal: true

module ShoperbLiquid
  class PaymentProviderDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    # stripe
    def type
      record.service
    end

    # pk_test_JqbMzr2NvnK25D5QEEm0OlZg
    def public_key
      record.public_key
    end
  end
end