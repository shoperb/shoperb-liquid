# frozen_string_literal: true

module ShoperbLiquid
  class CollectionDrop < Liquid::Drop
    attr_reader :collection

    def initialize(collection=nil)
      @collection = collection || []
    end

    def liquid_method_missing(method)
      collection.detect { |o| o.try(handle_method.to_sym) == method.to_s }
    end

    def each
      collection.each do |item|
        yield item.to_liquid
      end
    end

    def count
      collection.count
    end

    def size
      collection.size
    end

    def any?
      collection.any?
    end

    def many?
      collection.many?
    end

    def one?
      collection.one?
    end

    def empty?
      collection.empty?
    end

    def first
      collection.first.try(:to_liquid)
    end

    def last
      collection.last.try(:to_liquid)
    end

    def to_a
      collection.map(&:to_liquid)
    end

    def to_json
      collection.to_json
    end

    def inspect
      to_s
    end

    def pluck(key)
      to_a.collect(&key.to_sym)
    end

    def to_s
      self.class.to_s
    end

    protected

    def paginate(page, per_page)
      self.class.new(collection.page(page).per(per_page))
    end

    def limit_value
      (collection.respond_to?(:limit_value) && collection.limit_value) || 50
    end

    def limited
      (collection.respond_to?(:limit) && collection.limit(limit_value)) || collection.slice(0..limit_value)
    end

    def handle_method
      :handle
    end
  end
end
