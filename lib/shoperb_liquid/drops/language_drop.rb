# frozen_string_literal: true

module ShoperbLiquid
  class LanguageDrop < Base
    def name
      record.name
    end

    def code
      record.code
    end

    def active?
      record.active?
    end
  end
end
