# frozen_string_literal: true

module ShoperbLiquid
  class ReviewDrop < Base
    def initialize(record)
      @record = record || Review.new
    end

    def id
      record.id
    end

    def title
      record.title
    end

    def body
      record.body
    end

    def rating
      record.rating
    end

    def created_at
      record.created_at
    end

    def customer
      CustomerDrop.new(record.customer)
    end

    def product
      ProductDrop.new(record.product)
    end
  end
end
