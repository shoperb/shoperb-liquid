# frozen_string_literal: true

module ShoperbLiquid
  module Models
    extend self

    # some currently necessary
    # models + some potentially
    # necessary in future
    MODELS = [
      :Address,
      :BlogPost,
      :Cart,
      :CartItem,
      :Category,
      :Collection,
      :Country,
      :Currency,
      :Customer,
      :Discount,
      :Image,
      :Language,
      :Link,
      :MediaFile,
      :Menu,
      :Order,
      :OrderItem,
      :Page,
      :PaymentMethod,
      :Product,
      :ProductAttribute,
      :ProductType,
      :ProductSearch,
      :Shop,
      :Theme,
      :Variant,
      :VariantAttribute,
      :Vendor,
    ].freeze

    # Regardless whether client models are namespaced or not,
    # we create same constansts under ShoperbLiquid namespace,
    # so access to them would be easier from drops
    def shadow
      MODELS.each do |model_name|
        namespace = ShoperbLiquid.config.models_namespace
        absolute_klass_name = "::" + [namespace, model_name].compact.join("::")
        ShoperbLiquid.const_set(model_name, absolute_klass_name.constantize)
      end
    end
  end
end
