# frozen_string_literal: true

module ShoperbLiquid
  class SubscriptionPlanDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def invoice_name
      record.invoice_name
    end
    
    def description
      record.description
    end

    def handle
      record.handle
    end

    def interval
      record.interval
    end

    def interval_count
      record.interval_count
    end

    def price
      record.item_price
    end

    def setup_cost
      record.setup_cost
    end

    def trial_interval
      record.trial_interval
    end

    def trial_interval_count
      record.trial_interval_count
    end

    def create_subscription_url
      controller.store_account_create_subscription_path(id)
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
