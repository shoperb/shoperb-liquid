module ShoperbLiquid
  module HtmlFilters
    def modulo_word(word, index, modulo)
      index.to_i % modulo == 0 ? word : ""
    end

    def default_pagination(paginate, *args)
      return "" if paginate["parts"].empty?

      previous_label = ShoperbLiquid.config.translator.translate("navigation.previous")
      next_label     = ShoperbLiquid.config.translator.translate("navigation.next")

      previous_link = link("previous", previous_label, paginate)
      next_link     = link("next", next_label, paginate)

      links = ""
      paginate["parts"].each do |part|
        links << (if part["is_link"]
                    "<a class=\"page\" href=\"#{part["url"]}\">#{part["title"]}</a>"
                  elsif part["current"]
                    "<span class=\"page current\">#{part["title"]}</span>"
                  else
                    "<span class=\"page gap\">#{part["title"]}</span>"
                  end)
      end

      %{
        <div class="pagination">
          #{previous_link}
          #{links}
          #{next_link}
        </div>
      }
    end

    private

    def link(type, label, paginate)
      if paginate[type].blank?
        "<span class=\"disabled prev-page\">#{label}</span>"
      else
        "<a href=\"#{paginate[type]["url"]}\" class=\"prev-page\">#{label}</a>"
      end
    end
  end
end
