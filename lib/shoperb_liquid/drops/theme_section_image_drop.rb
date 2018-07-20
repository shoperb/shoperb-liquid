# frozen_string_literal: true

module ShoperbLiquid
  class ThemeSectionImageDrop < ImageDrop
    def to_s
      record.url
    end
  end
end
