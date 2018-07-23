# frozen_string_literal: true

require_relative "theme_settings_drop"

module ShoperbLiquid
  class ThemeSectionSettingsDrop < ThemeSettingsDrop
    attr_reader :section

    def initialize(section)
      @section = section
      @settings = section["settings"] || {}
      @translations = section["translations"] || {}
      @links = section["links"] || {}

      super(@settings)
    end

    protected

    def format_value(key, value)
      res = url(key, value) if @links[key]
      res ||= (@translations[current_locale] || {})[key] || value
    end

    def url(key, value)
      return unless @links[key]
      return value if @links[key]["style"].in?(immutable_link_styles)

      "/#{current_locale}#{value}"
      # parsed_path = routes.recognize_path(value)
      # routes.url_for(only_path: true, locale: current_locale, **parsed_path)
    end

    def immutable_link_styles
      %w(CUSTOM Blank)
    end
  end
end
