# frozen_string_literal: true

module ShoperbLiquid
  # Generates faceted/aggregated 
  #search markup data
  #
  # Usage:
  #
  # {% products_filter %}
  #   {% for search_group in groups %}
  #    {%assign param_name=search_group[0]%}
  #    {%assign param_conf=search_group[1]%}
  #    <span class="title">{{param_conf.name}}</span>
  #    <select name="{{param_name}}" class="values" multiple>
  #      {% for value in param_conf.values %}
  #        <option value="{{value}}">{{value}}</option>
  #      {% endfor %}
  #    </select>
  #   {% endfor %}
  # {% products_filter %}
  #
  class ProductsFilterTag < ::Liquid::Block
    # SYNTAX = /(#{::Liquid::QuotedFragment})/

    def initialize(tag_name, markup, tokens)
      super

      # if markup =~ SYNTAX
      #   @subject = $1.strip[1..-2]
      # else
      #   raise ShoperbLiquid::SyntaxError, "Error in tag 'layout' - Valid syntax: form 'form_name'"
      # end
    end
    
    def facets(context)
      {}
    end
    
    def render(context)
      
        
      context.stack do
        nodelist = []
        
        context["groups"] = facets(context).stringify_keys!
        nodelist << super # other part of html
        nodelist.join("<br />")
      end
    end
  end
end