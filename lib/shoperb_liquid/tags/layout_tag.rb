# frozen_string_literal: true

module ShoperbLiquid
  class LayoutTag < ::Liquid::Tag
    SYNTAX = /(#{::Liquid::QuotedFragment}+)(\s+(#{::Liquid::QuotedFragment}+))?/

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ SYNTAX
        @layout_name = $1
      else
        raise ShoperbLiquid::SyntaxError, "Error in tag 'layout' - Valid syntax: layout '[layout|none]'"
      end
    end

    def render(context)
      context.registers[:layouts] = @layout_name == "none" ? nil : @layout_name
    end
  end
end
