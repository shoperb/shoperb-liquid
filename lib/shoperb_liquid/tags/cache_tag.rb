# frozen_string_literal: true

module ShoperbLiquid
  #  Example {% cache product, arg1, arg2 %}
  class CacheTag < ::Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @attrs = markup.split(/[, .]/).select(&:present?).map(&:strip)
    end

    def render(context)
      context.stack do
        key_lookup = [
          "liquid.cached",
          cache_key(context.registers[:theme]),
          @markup,
          ::I18n.locale.to_s,
        ]

        @attrs.each do |attr|
          key = cache_key(context[attr])
          key_lookup << (key || attr)
        end

        ShoperbLiquid.config.cache.fetch(key_lookup) do
          super(context)
        end
      end
    end

    # using activerecord cache key when possible
    def cache_key(object)
      instance = nil
      instance = object            if object.respond_to?(:updated_at)
      instance = object.record     if object.respond_to?(:record)
      instance = object.collection if object.respond_to?(:collection)

      if instance && instance.respond_to?(:cache_key)
        instance.cache_key
      else
        object
      end
    end
  end
end
