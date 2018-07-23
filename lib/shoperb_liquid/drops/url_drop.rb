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
        controller.store_subscribers_add_path
      end

      def cart_add
        controller.add_store_cart_path
      end

      def cart_checkout
        controller.checkout_store_cart_path
      end

      def cart_update
        controller.update_store_cart_path
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

      def auth_input
        name  = controller.try(:request_forgery_protection_token).to_s
        value = controller.try(:form_authenticity_token)

        %(<input type="hidden" name="#{name}" value="#{value}">)
      end
    end
  end
end
