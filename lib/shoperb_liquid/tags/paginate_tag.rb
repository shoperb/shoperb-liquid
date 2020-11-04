# frozen_string_literal: true

module ShoperbLiquid
  # StrictQuotedFragment = /"[^"]+"|'[^']+'|[^\s|:,]+/
  # FirstFilterArgument  = /#{FilterArgumentSeparator}(?:#{StrictQuotedFragment})/o
  # OtherFilterArgument  = /#{ArgumentSeparator}(?:#{StrictQuotedFragment})/o
  # SpacelessFilter      = /^(?:'[^']+'|"[^"]+"|[^'"])*#{FilterSeparator}(?:#{StrictQuotedFragment})(?:#{FirstFilterArgument}(?:#{OtherFilterArgument})*)?/o
  # Expression           = /(?:#{QuotedFragment}(?:#{SpacelessFilter})*)/o
  # Paginate a collection
  #
  # Usage:
  #
  # {% paginate contents.projects by 5 %}
  #   {% for project in paginate.collection %}
  #     {{ project.name }}
  #   {% endfor %}
  #  {% endpaginate %}
  #
  class PaginateTag < ::Liquid::Block
    Syntax = /(#{::Liquid::QuotedFragment})\s*(by\s*(\w+))?/
    DEFAULT_PER = 20
    MAXIMUM_PER = 100

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ Syntax
        @collection_name = $1
        @page_size       = $2 ? $3 : DEFAULT_PER # save number hardcoded or variable name

        @attributes = { "window_size" => 3 }

        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      else
        raise ShoperbLiquid::SyntaxError, "Syntax Error in 'paginate' - Valid syntax: paginate <collection> by <number>"
      end

      super
    end

    def get_page_number(per)
      return @get_page_number if @get_page_number

      @get_page_number = per.to_i
      @get_page_number = (@context.scopes.last[per] || DEFAULT_PER).to_i if @get_page_number == 0
      @get_page_number = MAXIMUM_PER if @get_page_number > MAXIMUM_PER

      @get_page_number
    end

    # @page_size - is number or reference
    def render(context)
      @context = context

      context.stack do
        collection = context[@collection_name]
        collection ||= CollectionDrop.new(Product.none)

        current    = context["current_page"].to_i == 0 ? 1 : context["current_page"].to_i
        pagy,scope = collection.send(:paginate, current, get_page_number(@page_size))

        paginator = {
          total:      pagy.count,
          last:       pagy.count - 1,
          pages:      pagy.pages,
          size:       pagy.items,
          offset:     pagy.offset,
          first:      1,
          page:       current,
          previous:   nil,
          next:       nil,
          parts:      [],
          collection: scope,
        }

        path         = context["path"]
        other_params = context["get_params"]

        has_prev_page = (paginator[:page] - 1) >= 1
        has_next_page = (paginator[:page] + 1) <= pagy.pages

        previous_text = ShoperbLiquid.config.translator.translate("navigation.previous", locale: context.registers[:locale])
        next_text = ShoperbLiquid.config.translator.translate("navigation.next", locale: context.registers[:locale])

        paginator[:previous] = link(previous_text, paginator[:page] - 1, path, other_params) if has_prev_page
        paginator[:next]     = link(next_text,     paginator[:page] + 1, path, other_params) if has_next_page

        hellip_break = false

        if paginator[:pages] > 1
          1.upto(paginator[:pages]) do |page|
            if paginator[:page] == page
              paginator[:parts] << no_link(page)
            elsif page == 1
              paginator[:parts] << link(page, page, path, other_params)
            elsif page == paginator[:pages]
              paginator[:parts] << link(page, page, path, other_params)
            elsif page <= paginator[:page] - window_size || page >= paginator[:page] + window_size
              next if hellip_break
              paginator[:parts] << no_link("&hellip;")
              hellip_break = true
              next
            else
              paginator[:parts] << link(page, page, path, other_params)
            end

            hellip_break = false
          end
        end

        context["paginate"] = paginator.stringify_keys!

        super
      end
    end

    private

    def window_size
      @attributes["window_size"]
    end

    def no_link(title)
      { "title" => title, "is_link" => false, "current" => title != "&hellip;" }
    end

    def link(title, page, path, other_params={})
      params = other_params.merge("page" => page)
      { "title" => title, "url" => path + "?#{params.to_query}", "is_link" => true }
    end
  end
end
