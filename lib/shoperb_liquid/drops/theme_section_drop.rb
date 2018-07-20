# frozen_string_literal: true

module ShoperbLiquid
  class ThemeSectionDrop < Base
    def initialize(id, section)
      @id = id
      @record = section || {}
    end

    def id
      @id
    end

    def blocks
      ThemeSectionBlocksDrop.new(record["blocks"], record["block_order"])
    end

    def settings
      ThemeSectionSettingsDrop.new(record)
    end

    def type
      record["type"]
    end
  end
end
