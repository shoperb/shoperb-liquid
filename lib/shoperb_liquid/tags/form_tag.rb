# frozen_string_literal: true

module ShoperbLiquid
  # Generates feedback form
  #
  # Usage:
  #
  # {% form 'name' %}
  #   html
  # {% endform %}
  # <input name="subject"> - will be used for subject. Other ones will be used for body
  #
  class FormTag < ::Liquid::Block
    SYNTAX = /(#{::Liquid::QuotedFragment})/

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ SYNTAX
        @subject = $1.strip[1..-2]
      else
        raise ShoperbLiquid::SyntaxError, "Error in tag 'layout' - Valid syntax: form 'form_name'"
      end
    end

    def render(context)
      context.stack do
        nodelist = []
        nodelist << %(<form action='/submit-form' method="post">)
        nodelist << %(<input type="text" name="contact_form_name" value="#{@subject}" style="color: black; display: none;" />)
        nodelist << auth_token(context)
        nodelist << super(context)
        nodelist << %(</form>)

        nodelist.join
      end
    end

    # returns input with protection token and honeypot protection
    def auth_token(context)
      controller = context.registers[:controller]
      value = controller.send(:form_authenticity_token)

      %(<input type="hidden" name="authenticity_token" value="#{value}"> <input autocomplete="nope" type="search" tabindex="-1" name="shoperb_first_last_name_1" value="" style="color: black; display: none;" />)
    end
  end
end
