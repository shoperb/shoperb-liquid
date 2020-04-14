# frozen_string_literal: true

module ShoperbLiquid
  class SearchDrop < Base
    def initialize(word="", options={})
      @record = ProductSearch.new(word: word, **options.to_h)
    end

    def paginate(page=1, search_size=25)
      return self unless searching?

      page        &&= page.to_i
      search_size &&= search_size.to_i

      record.paginate(page: page, per: search_size)
    end

    def performed
      record.performed
    end

    def terms
      record.terms
    end

    def results
      record.results
    end

    alias_method :collection, :results
    delegate :any?, :each, :map, to: :results

    def size
      record.results_size
    end

    def searching?
      record.searching?
    end

    def to_curl
      record.to_curl
    end
  end
end
