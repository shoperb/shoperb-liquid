# frozen_string_literal: true

module ShoperbLiquid
  module UrlFilters
    include ActionView::Helpers::UrlHelper

    def link_to_category(category)
      link_to category.name, category.url, category.name
    end

    def link_to_product(product)
      link_to product.name, product.url, product.name
    end

    def link_to_page(page)
      link_to page.name, page.url, page.name
    end

    def link_to_collection(collection)
      link_to collection.name, collection.url, collection.name
    end

    def link_to_order(obj)
      link_to obj.name, obj.url, obj.name
    end

    def link_to_locale(text, locale)
      link_to text, url_to_locale(locale)
    end

    def url_to_locale(locale)
      pars = {locale: locale}
      pars[:query] =  @context["params"]["query"] if @context["params"]["query"].present? # need for search

      controller = @context.registers[:controller]
      if @context["params"]["id"] && (obj = @context["object"]) && obj.respond_to?(:permalink)
        pars["id"] = in_locale(locale) {obj.record.to_param}
      end
      controller.url_for(pars)
    end

    def link_to_root(text)
      link_to text, "/#{@context["params"]["locale"]}"
    end

    def link_to(text, url, title=nil)
      super text, url, title: title
    end

    private
    def in_locale(local_locale)
      klass = ::Shoperb::Theme::Editor::Translations
      old = klass.locale
      klass.locale = local_locale
      resp = yield
      klass.locale = old
      resp
    end
  end
end
