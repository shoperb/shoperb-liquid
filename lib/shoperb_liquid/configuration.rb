# frozen_string_literal: true

module ShoperbLiquid
  class Configuration
    attr_accessor :cache, :file_system, :translator,
      :assets_remote_host, :environment, :routes,
      :models_namespace, :error_mode, :error_notify

    def initialize
      @cache        = default_cache
      @file_system  = default_file_system
      @translator   = default_translator
      @routes       = default_routes
      @error_mode   = Liquid::Environment.error_mode = :lax
      @error_notify = default_error_notify
      @models_namespace = nil
    end

    def file_system=(value)
      @file_system = Liquid::Environment.file_system = value
    end

    def environment=(value)
      @environment = value.to_s.inquiry
    end

    def error_mode=(value)
      @error_mode = Liquid::Environment.error_mode = value
    end

    def models_namespace=(namespace)
      if namespace != @models_namespace
        @models_namespace = namespace
        ShoperbLiquid::Models.shadow
      end
    end

    def error_notify(*args)
      @error_notify.call(*args)
    end

    private

    def default_cache
      ActiveSupport::Cache::MemoryStore.new
    end

    def default_translator
      AbstractTranslator.new
    end

    def default_file_system
      AbstractFileReader.new
    end

    def default_routes
      AbstractRoutesHelper.new
    end

    def default_error_notify
      lambda { |error, template, line| }
    end

    #
    # File reader class should implement following methods
    # so liquid knew where to fetch files from
    #
    class AbstractFileReader
      def read_template_file(*args)
        raise ShoperbLiquid::Error, "No file system given to read template file"
      end

      def read_section_file(*args)
        raise ShoperbLiquid::Error, "No file system given to read section file"
      end

      def absolute_asset_path(*args)
        raise ShoperbLiquid::Error, "No file system given to detect absolute asset path"
      end
    end

    #
    # Class, which is reponsible for fetching transltions
    # should implement following methods
    #
    class AbstractTranslator
      def translate(string, **args)
        string
      end

      def locale
        :en
      end
    end

    #
    # Class, which is reponsible for building urls
    # should implement following methods
    #
    class AbstractRoutesHelper
      PATHS = [
        :store_root_path,
        :store_cart_path,
        :store_carts_path,
        :store_signup_path,
        :store_login_path,
        :store_logout_path,
        :store_account_path,
        :add_store_account_billing_payment_methods_path,
        :store_account_billing_payment_method_path,
        :delete_store_account_billing_payment_method_path,
        :store_address_path,
        :store_addresses_path,
        :store_blog_post_path,
        :store_blog_posts_path,
        :store_brand_path,
        :store_brands_path,
        :store_category_path,
        :store_categories_path,
        :store_checkout_order_url,
        :store_collection_path,
        :store_collections_path,
        :store_order_path,
        :store_orders_path,
        :store_page_path,
        :store_pages_path,
        :store_product_path,
        :store_products_path,
        :store_variants_path,
        :store_subscribers_add_path,
        :store_search_path,
        :store_recover_password_path,
        :store_reset_password_path,
        :new_store_address_path,
        :add_store_cart_path,
        :checkout_store_cart_path,
        :update_store_cart_path,
        :add_store_multi_cart_path,
        :checkout_store_multi_cart_path,
        :update_store_multi_cart_path,
        :store_new_login_path,
        :store_upd_reset_password_path,
        :store_account_subscriptions_path,
        :store_account_subscription_plans_path,
        :store_account_create_subscription_path,
        :store_order_returns_path,
        :store_order_return_path,
        :new_store_order_return_path,
        :store_order_return_generate_parcel_path,
      ].freeze

      PATHS.each do |path|
        define_method path do |*_|
          raise_not_implemented(path)
        end
      end

      def url_for(*_)
        raise_not_implemented(:url_for)
      end

      private

      def raise_not_implemented(path)
        raise ShoperbLiquid::Error, "Cannot build url #{path} with given routes helper"
      end
    end
  end
end
