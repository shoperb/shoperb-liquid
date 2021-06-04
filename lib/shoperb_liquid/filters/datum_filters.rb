# frozen_string_literal: true

module ShoperbLiquid
  #
  # Helpers for working with strings,
  # numbers, money, dates, weight units
  #
  module DatumFilters
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::OutputSafetyHelper

    # either with symbol or code
    def money(money)
      _money(money, precision: money_precision(money))
    end

    def money_with_cents(money)
      _money(money, precision: 2)
    end

    # with both symbol and code
    def money_with_currency(money)
      "#{_money(money, precision: 2)} #{shop.currency.code}"
    end

    def money_precision(money)
      fmt = "%05.2f" % money.to_f
      _, cost_cents = fmt.split "."

      cost_cents.to_i == 0 ? 0 : 2
    end

    # just numbers
    def money_without_currency(money)
      number_to_currency(money, unit: "", delimiter: " ")
    end

    def without_cents(money)
      money.to_i
    end

    def num_with_2_meaning_nums(money)
      "%05.2f" % money
    end

    def weight_with_unit(weight, precision=nil)
      return if weight.nil?

      weight = "%.#{precision}f" % weight if precision

      "#{weight} #{shop.metric? ? "kg" : "lbs"}" # TODO
    end

    def dimension_with_unit(size)
      "#{size} #{shop.metric? ? "cm" : "inch"}" # TODO
    end

    def upcase(value)
      value.to_s.upcase
    end

    def downcase(value)
      value.to_s.downcase
    end

    def titleize(value)
      value.to_s.titlecase
    end

    def size(value)
      value.size rescue value.to_s.size
    end

    def date(value, formatting)
      return unless value

      value = Time.now if value.eql?("now")
      date  = value.kind_of?(String) ? Date.parse(value) : value
      I18n.l(date, format: formatting)
    end

    def pluck(value, key)
      value.pluck(key)
    end

    def json(value)
      value.to_json if value.is_a?(CollectionDrop)
    end

    def debug(object)
      safe_join(["<pre>".html_safe, object.inspect, "</pre>".html_safe], "\n")
    end

    def numeric(value)
      value.to_i
    end

    def plus(value, add)
      value.to_i + add
    end

    def minus(value, remove)
      value.to_i - remove
    end

    # we use default times filter
    # def times(value, times)
    #   value.to_i * times.to_i
    # end

    def decimal_times(value, times)
      value.to_d * times.to_d
    end

    def random(value, limit=nil)
      return value unless limit
      value.to_a.sample limit
    end
    deprecate :random

    def sum(collection, field)
      collection.pluck(field).sum
    end

    protected

    def shop
      @context["shop"]
    end

    private

    def _money(money, **args)
      if shop.currency.symbol
        number_to_currency(money, unit: shop.currency.symbol, format: "%u%n", delimiter: " ", **args)
      else
        number_to_currency(money, unit: shop.currency.code, format: "%n %u", delimiter: " ", **args)
      end
    end
  end
end
