# frozen_string_literal: true

module ShoperbLiquid
  module Url
    # paths to generate links
    class GetDrop < Base
      def initialize; end

      def root
        routes.store_root_path
      end

      def products
        routes.store_products_path
      end

      def collections
        routes.store_collections_path
      end

      def cart
        routes.store_cart_path
      end

      def signup
        routes.store_signup_path
      end

      def login
        routes.store_login_path
      end

      def logout
        routes.store_logout_path
      end

      def account
        routes.store_account_path
      end

      def recover
        routes.store_recover_password_path
      end

      def reset
        routes.store_reset_password_path
      end

      def orders
        routes.store_orders_path
      end

      def addresses
        routes.store_addresses_path
      end

      def new_address
        routes.new_store_address_path
      end

      def search
        routes.store_search_path
      end

      def blog
        routes.store_blog_posts_path
      end

      def current_url
        request.try(:url)
      end

      def current_path
        request.try(:path)
      end

      def current_host
        request.try(:host)
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
        routes.store_subscribers_add_path
      end

      def cart_add
        routes.add_store_cart_path
      end

      def cart_checkout
        routes.checkout_store_cart_path
      end

      def cart_update
        routes.update_store_cart_path
      end

      def signup
        routes.store_signup_path
      end

      def new_login
        routes.store_new_login_path
      end

      def account
        routes.store_account_path
      end

      def password_request
        routes.store_recover_password_path
      end

      def password_change
        routes.store_upd_reset_password_path
      end

      def address_create
        routes.store_addresses_path
      end

      def auth_input
        name  = controller.try(:request_forgery_protection_token).to_s
        value = controller.try(:form_authenticity_token)

        %(<input type="hidden" name="#{name}" value="#{value}">)
      end
    end
  end
end
