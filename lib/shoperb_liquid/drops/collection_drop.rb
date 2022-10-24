# frozen_string_literal: true

module ShoperbLiquid
  class CollectionDrop < Liquid::Drop
    include Pagy::Backend

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
      collection.size
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

    def sorted
      collection.sorted
    end

    def to_s
      self.class.to_s
    end

    protected

    def paginate(page, per_page)
      pagy, items = if (collection.respond_to?(:paginate))
        collection.paginate(page, per_page)

      elsif collection.is_a?(Array)
        # copy of pagy/extras/array
        pagy = Pagy.new(count: collection.size,  page:  page, items: per_page)
        [pagy, collection[pagy.offset, pagy.items]]

      else
        loc_coll = collection.dup
        # support for shoperb website when it tries not to load all data at once
        loc_coll = loc_coll.unscope(:limit,:offset) if loc_coll.respond_to?(:unscope)
        pagy(loc_coll, items: per_page, page: page)
      end

      return pagy, self.class.new(items)
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
