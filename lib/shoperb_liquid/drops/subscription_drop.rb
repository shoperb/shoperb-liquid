# frozen_string_literal: true

module ShoperbLiquid
  class SubscriptionDrop < Base
    def id
      record.id
    end
    def plan
      record.plan.to_liquid
    end
    def auto_collection?
      record.auto_collection
    end
    def active?
      record.active?
    end
    def in_trial?
      record.in_trial?
    end
    def qty
      record.qty
    end
    def starts_at
      record.starts_at
    end
    def ends_at
      record.ends_at
    end
    def trial_starts_at
      record.trial_starts_at
    end
    def trial_ends_at
      record.trial_ends_at
    end
    def deleted?
      record.deleted?
    end

    def state
      record.state
    end
    
    def gift_card_code
      record.gift_card_code
    end

    def delete_url
      controller.store_account_delete_subscription_path(id)
    end
  end
end
