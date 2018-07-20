# frozen_string_literal: true

module ShoperbLiquid
  class PageDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def content
      record.content
    end

    def url
      routes.store_page_path(record)
    end
  end
end
