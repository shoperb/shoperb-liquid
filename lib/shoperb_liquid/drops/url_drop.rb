# frozen_string_literal: true

module ShoperbLiquid
  module Url
    # paths to generate links
    class GetDrop < Base
      def initialize; end

      def root
        controller.store_root_path
      end

      def products
        controller.store_products_path
      end

      def collections
        controller.store_collections_path
      end

      def cart
        controller.store_cart_path
      end

      def signup
        controller.store_signup_path
      end

      def login
        controller.store_login_path
      end

      def logout
        controller.store_logout_path
      end

      def account
        controller.store_account_path
      end

      def recover
        controller.store_recover_password_path
      end

      def reset
        controller.store_reset_password_path
      end

      def orders
        controller.store_orders_path
      end

      def addresses
        controller.store_addresses_path
      end

      def new_address
        controller.new_store_address_path
      end

      def search
        controller.store_search_path
      end

      def blog
        controller.store_blog_posts_path
      end

      def current_url
        request.try(:url)
      end

      def canonical_url
        controller.url_for(only_path: false)
      end

      def current_path
        request.try(:path)
      end

      def canonical_path
        controller.url_for(only_path: true)
      end

      def current_host
        request.try(:host)
      end

      def billing_payment_methods
        controller.store_account_billing_payment_methods_path
      end

      def new_billing_payment_method
        controller.add_store_account_billing_payment_methods_path
      end

      def account_subscriptions
        controller.store_account_subscriptions_path
      end

      def account_subscription_plans
        controller.store_account_subscription_plans_path
      end

      def account_create_subscription
        controller.store_account_create_subscription_path
      end

      def order_returns
        controller.store_order_returns_path
      end

      def new_order_returns
        controller.new_store_order_return_path
      end

      private

      def request
        controller.try(:request)
      end
    end

    # Paths to generate form actions
    class PostDrop < Base
      def initialize; end

      def add_subscriber
        controller.store_subscribers_add_path
      end

      def cart_add
        controller.add_store_cart_path
      end

      def cart_checkout
        controller.checkout_store_cart_path
      end

      def cart_update
        val = controller.update_store_cart_path
        val = val[0..-2] if val.ends_with?('/')
        val
      end

      def signup
        controller.store_signup_path
      end

      def new_login
        controller.store_new_login_path
      end

      def account
        controller.store_account_path
      end

      def password_request
        controller.store_recover_password_path
      end

      def password_change
        controller.store_upd_reset_password_path
      end

      def address_create
        controller.store_addresses_path
      end

      def reviews
        controller.store_reviews_path
      end

      def variants
        controller.store_variants_path
      end

      def auth_input
        name  = controller.try(:request_forgery_protection_token).to_s
        value = controller.send(:form_authenticity_token) rescue nil

        %(<input type="hidden" name="#{name}" value="#{value}"> <input autocomplete="off" type="text" name="first_last_name" value="" class="shoperb_authenticity_token" />
        <style>
          .shoperb_authenticity_token{
              opacity: 0;
              position: absolute;
              top: 0;
              left: 0;
              height: 0;
              width: 0;
              z-index: -1;
          }
      </style>
        )
      end
    end
  end
end
