# frozen_string_literal: true

require "request_store"

module ShoperbLiquid
  module Registers
    extend self

    def register_filters
      Liquid::Template.register_filter ShoperbLiquid::UrlFilters
      Liquid::Template.register_filter ShoperbLiquid::DatumFilters
      Liquid::Template.register_filter ShoperbLiquid::AssetFilters
      Liquid::Template.register_filter ShoperbLiquid::CollectionFilters
      Liquid::Template.register_filter ShoperbLiquid::HtmlFilters
      Liquid::Template.register_filter ShoperbLiquid::TranslateFilters
      Liquid::Template.register_filter ShoperbLiquid::ExtensionFilters
      Liquid::Template.register_filter ShoperbLiquid::ThemeFilters
    end

    def register_tags
      Liquid::Template.register_tag "layout",   ShoperbLiquid::LayoutTag
      Liquid::Template.register_tag "paginate", ShoperbLiquid::PaginateTag
      Liquid::Template.register_tag "form",     ShoperbLiquid::FormTag
      Liquid::Template.register_tag "section",  ShoperbLiquid::SectionTag
      Liquid::Template.register_tag "cache",    ShoperbLiquid::CacheTag
      Liquid::Template.register_tag "products_filter",  ShoperbLiquid::ProductsFilterTag
      ''
    end

    def options(context, locals)
      context.instance_eval do
        params = self.params
        params = params.to_unsafe_h if params.respond_to?(:to_unsafe_h)
        params = params.to_h.with_indifferent_access

        {
          errors:        CollectionDrop.new(flash[:errors]),
          meta:          MetaDrop.new(locals.delete(:meta)),
          categories:    CategoriesDrop.new,
          cart:          CartDrop.new(current_cart),
          carts:         CollectionDrop.new(current_carts.map{|cart| CartDrop.new(cart)}),
          menus:         MenusDrop.new,
          pages:         PagesDrop.new,
          blog_posts:    CollectionDrop.new(BlogPost.active),
          blog_categories: CollectionDrop.new(BlogCategory.active),
          countries:     CollectionDrop.new(Country.all),
          vendors:       VendorsDrop.new,
          brands:        VendorsDrop.new,
          media_files:   CollectionDrop.new(MediaFile.includes(:file)),
          search:        SearchDrop.new(params[:query], params[:options]),
          shop:          ShopDrop.new(locals[:shop]),
          current_page:  (params[:page].to_i rescue 1),
          path:          request.path,
          params:        params,
          flash:         flash.to_hash.stringify_keys,
          get_params:    request.query_parameters,
          template_name: locals[:template].to_s,
          url:           Url::GetDrop.new,
          form_actions:  Url::PostDrop.new,
          paths:         Url::PostDrop.new, # alias
          geoip:         RequestStore["country_code"],
          collections:   ProductCollectionsDrop.new,
          products:      ProductsDrop.new,
          account:       CustomerDrop.new(current_customer),
          settings:      ThemeSettingsDrop.new(current_settings),
          preview:       params[:theme_id].present?,
          edit_preview:  params[:iframe_uuid].present?,
          integrations:  IntegrationsDrop.new(locals[:shop].grouped_integrations),
          preconnects:   defined?(ResourceHints) ? ResourceHints.preconnects : [],
          product_types: ProductTypesDrop.new,
          plans:         CollectionDrop.new(CustomerSubscriptionPlan.active),
        }
      end
    end
  end
end
