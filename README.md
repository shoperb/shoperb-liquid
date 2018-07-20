# ShoperbLiquid

ShoperbLiquid gem provides all the necessary filters, tags and drops for Liquid part of Shoperb and RTE.

## Installation

Add this line to your application's Gemfile:

    gem 'shoperb_liquid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shoperb_liquid

## Usage

You can configure the gem the following way:

```
ShoperbLiquid.configure do |config|
  config.cache = MyCacheClass.new
  config.translator = I18n
  config.assets_remote_host = "https://cdn.my-assets.com"
  config.routes = Rails.application.routes.url_helpers
  config.environment = :development
  config.models_namespace = nil
  conifg.file_system = MyFileSystem.new
  config.error_mode = :strict
end
```

### cache

Accepts an instance of class, respondible to caching, which implements methods "fetch", "read", "write". Cache is used for Cache liquid tag.

Example: ActiveSupport::Cache::MemoryStore.new, ActiveSupport::Cache::FileStore.new, ActiveSupport::Cache::MemCacheStore.new, etc.

### translator

Translator is expecting to recieve an instance of class, which is responsible for translating strings inside the theme. It should implement methods "translate" and "locale". It can be I18n or it can be any other custom class, which reads translation strings from some other places (database).

### assets_remote_host

This configuration defines the remote host for assets (if any) and is used in such liquid filters, like theme_filters#customize.

### routes

This config is expecting a class, which is responsible for building urls. It should work a lot like rails routes helper and implement following methods:

* store_root_path
* store_cart_path
* store_signup_path
* store_login_path
* store_logout_path
* store_account_path
* store_address_path
* store_addresses_path
* store_blog_post_path
* store_blog_posts_path
* store_brand_path
* store_brands_path
* store_category_path
* store_categories_path
* store_checkout_order_url
* store_collection_path
* store_collections_path
* store_order_path
* store_orders_path
* store_page_path
* store_pages_path
* store_product_path
* store_products_path
* store_subscribers_add_path
* store_search_path
* store_recover_password_path
* store_reset_password_path
* new_store_address_path
* add_store_cart_path
* checkout_store_cart_path
* update_store_cart_path
* store_new_login_path
* store_upd_reset_password_path

### environment

Accepts values: products, development, test, (any other) + theme_development, which would rather by used by RTE.

### models_namespace

In case if your models are namespaced, you can provide the namespace name in this config.

### file_system

File System is a class, responsible for fetching theme files (for example from the file system or database). It should implement following methods:

* __read_template_file__: (should fetch template or fragment)
* __read_section_file__: (should fetch section)
* __absolute_asset_path__: (should return absolute path of an asset by its relative (or basename) path). For instance Shoperb side needs to print correct pathname with a digest, taken from database.

### error_mode

Liquid error mode. Values: strict, :warn, lax (default).

## Liquid template options

Options, provided to the template, are passed by __shoperb_liquid__ gem. However, options should be built in the appropriate context. In order for them to be built correctly, context should have following variables:

* __params__: hash
* __options__: hash
* __flash__: hash
* __shop__: object
* __request__: object
* __template__: string
* __current_cart__: object
* __current_customer__: object
* __current_settings__: hash
* __ResourceHints__: object (optional)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/shoperb_liquid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
