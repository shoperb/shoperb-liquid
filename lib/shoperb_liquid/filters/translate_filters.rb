# frozen_string_literal: true

module ShoperbLiquid
  #
  # Translating of strings in the theme
  #
  module TranslateFilters
    def translate(string, args = {})
      args[:theme] = @context.registers[:theme]
      translation = ShoperbLiquid.config.translator.translate(string, **args.symbolize_keys)
      Liquid::Template.parse(translation || "").render(args.stringify_keys)
    end

    alias_method :t, :translate
  end
end
