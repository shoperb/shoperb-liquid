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
      locals = @context.environments[0].symbolize_keys
      record.content(@context.registers[:theme], controller, locals)
    end

    def url
      controller.store_page_path(record)
    end
  end
end
