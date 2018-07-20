# frozen_string_literal: true

module ShoperbLiquid
  #
  # Translating of strings in the theme
  #
  module TranslateFilters
    def translate(string, **args)
      ShoperbLiquid.config.translator.translate(string, args)
    end

    alias_method :t, :translate
  end
end
