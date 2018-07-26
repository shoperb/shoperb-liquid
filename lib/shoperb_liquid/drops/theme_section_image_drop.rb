# frozen_string_literal: true

require_relative 'image_drop'

module ShoperbLiquid
  class ThemeSectionImageDrop < ImageDrop
    def to_s
      record.url
    end
  end
end
