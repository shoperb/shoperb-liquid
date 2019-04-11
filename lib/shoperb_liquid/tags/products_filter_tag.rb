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
    def initialize(tag_name, markup, tokens)
      super
    end
    
    def facets(context)
      json = {}
      row = {}
      context["products"].to_a.each_with_index do |pr, product_idx|
        last_product=nil
        pr.variants.each do |v|
          v.attributes.each do |va|
            json[va.handle]                             ||= { "name"  => va.name, "values" => {}}
            json[va.handle]["values"][va.value]         ||= { "label" => va.value, "count" => 1 }
            json[va.handle]["values"][va.value]["count"] += 1 if last_product != product_idx
          end
          last_product=product_idx
          
          row[:min] = v.price.to_d if row[:min].nil? || row[:min] > v.price.to_d
          row[:max] = v.price.to_d if row[:max].nil? || row[:max] < v.price.to_d
        end
      end

      json["price"] = {
          "name"   => "Price",
          "values" => {
              "min" => {"label"=>"Minimum", "count"=>row[:min]},
              "max" => {"label"=>"Maximum", "count"=>row[:max]}
          }
      }
      json
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