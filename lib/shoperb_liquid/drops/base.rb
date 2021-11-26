# frozen_string_literal: true

module ShoperbLiquid
  class Base < ::Liquid::Drop
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def inspect
      meths = self.class.invokable_methods - Set["to_liquid","record"]
      meths.delete_if{|meth| meth.end_with?("_url")}
      json = meths.each_with_object({}){|meth,h| h[meth] = (public_send(meth).to_s rescue "")}.to_json
      "#{self.class}(#{record.id})#{json}"
    end

    protected

    def try_int(num)
      # the fastest way to compare, through float
      int = num.to_i
      int.to_f == num.to_f ? int : num
    end

    def routes
      ShoperbLiquid.config.routes
    end

    # if email sets his own customer then use that one
    def current_customer
      if @context.key?("customer")
        @context["customer"]
      elsif @context.environments[0]&.has_key?("customer")
        @context.environments[0]["customer"]
      else
        controller.current_customer
      end
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
