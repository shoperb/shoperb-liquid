# frozen_string_literal: true

module ShoperbLiquid
  class PaymentCardDrop < Base
    def id
      record.id
    end

    def url
      controller.store_account_billing_payment_method_path(id)
    end

    def delete_url
      controller.delete_store_account_billing_payment_method_path(id)
    end

    # stripe
    def service
      record.service
    end

    # {"name"=>nil, "brand"=>"Visa", "last4"=>"4242",
    # "country"=>"US", "exp_year"=>2022, "exp_month"=>11, "type"=>"credit"} 
    def card
      record.card
    end
  end
end
    