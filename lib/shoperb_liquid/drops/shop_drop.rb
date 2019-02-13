# frozen_string_literal: true

module ShoperbLiquid
  class ShopDrop < Base
    def name
      record.name
    end

    def email
      record.email
    end

    def domain
      record.external_hostname
    end

    def meta_title
      record.meta_title
    end

    def meta_keywords
      record.meta_keywords
    end

    def meta_description
      record.meta_description
    end

    def current?
      record.id == shop.id
    end

    def metric?
      record.metric?
    end

    def address
      AddressDrop.new(record.address) if record.address
    end

    def language
      LanguageDrop.new(record.language) if record.language
    end

    def current_locale
      super
    end

    def possible_languages
      record.all_languages
    end

    def currency
      CurrencyDrop.new(record.currency)
    end

    def account
      AccountDrop.new(record.account)
    end

    def customer_accounts
      record.customer_accounts
    end

    def account_types
      record.account_types
    end

    def google_analytics
      record.tracking_script.try(:google).try(:presence)
    end

    def reviews?
      record.reviews
    end
  end
end
