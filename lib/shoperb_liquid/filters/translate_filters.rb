# frozen_string_literal: true

module ShoperbLiquid
  #
  # Translating of strings in the theme
  #
  module TranslateFilters
    def translate(string, **args)
      args[:theme] = @context.registers[:theme]
      string = ShoperbLiquid.config.translator.translate(string, args)
      Liquid::Template.parse(string || "").render(args.stringify_keys)
    end

    alias_method :t, :translate
  end
end
