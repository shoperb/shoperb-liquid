# frozen_string_literal: true

module ShoperbLiquid
  # Generates faceted/aggregated
  # search markup data
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
  # you can also use next variables like `products_filter, what: 'full'`:
  #   * what - one of ['full', 'labels'], default: 'full'
  class ProductsFilterTag < ::Liquid::Block
    FULL   = 'full'
    LABELS = 'labels'
    def initialize(tag_name, markup, options)
      @parse_context = options # mark for parser
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        # define liquid 4 or 5. parse_expression is for 5
        @attributes[key] = defined?(parse_expression) ? parse_expression(value) : Liquid::Expression.parse(value)
      end

      @attributes["what"] ||= FULL

      super
    end

    def facets(context)
      json    = {}
      row     = {}
      pr_idxs = {}
      context["products"].to_a.each_with_index do |pr, product_idx|
        pr.variants.each do |v|
          v.attributes.each do |va|
            pr_idxs["#{va.handle}:#{va.value}"] ||= Set.new
            pr_idxs["#{va.handle}:#{va.value}"].add(product_idx)
            json[va.handle]                             ||= { "name"  => va.name, "values" => {}}
            json[va.handle]["values"][va.value]         ||= { "label" => va.value, "count" => 1 }
            json[va.handle]["values"][va.value]["count"]  = pr_idxs["#{va.handle}:#{va.value}"].size
          end

          row[:min] = v.price.to_d if row[:min].nil? || row[:min] > v.price.to_d
          row[:max] = v.price.to_d if row[:max].nil? || row[:max] < v.price.to_d
        end
      end

      set_prices(json, row)
      json
    end

    def labels(context)
      json    = {}
      row     = {}
      context["products"].to_a.each_with_index do |pr, product_idx|
        pr.variants.each do |v|
          v.attributes.each do |va|
            json[va.handle] ||= { "name"  => va.name, "values" => {}}
          end

          row[:min] = v.price.to_d if row[:min].nil? || row[:min] > v.price.to_d
          row[:max] = v.price.to_d if row[:max].nil? || row[:max] < v.price.to_d
        end
      end

      set_prices(json, row)
      json
    end

    def set_prices(json, row)
      json["price"] = {
          "name"   => "Price",
          "values" => {
              "min" => {"label"=>"Minimum", "count"=>row[:min]},
              "max" => {"label"=>"Maximum", "count"=>row[:max]}
          }
      }
    end


    # liquid < 5.0
    def render(context)
      context.stack do
        nodelist = []
        context["groups"] = case @attributes["what"]
        when FULL   then facets(context).stringify_keys!
        when LABELS then labels(context).stringify_keys!
        else {}
        end
        nodelist << super # other part of html
        nodelist.join("<br />")
      end
    end
  end
end
