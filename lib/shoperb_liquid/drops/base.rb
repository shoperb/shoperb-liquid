# frozen_string_literal: true

module ShoperbLiquid
  class Base < ::Liquid::Drop
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def inspect
      "#{self.class}(#{record.id})"
    end

    protected

    def routes
      ShoperbLiquid.config.routes
    end

    def current_customer
      controller.current_customer
    end

    def controller
      @context.registers[:controller]
    end

    def shop
      @context && @context["shop"]
    end

    def current_locale
      ShoperbLiquid.config.translator.locale
    end
  end
end
