# frozen_string_literal: true

module ShoperbLiquid
  class MenuDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def links
      CollectionDrop.new(record.links)
    end

    def root_links
      CollectionDrop.new(record.links.where(parent_id: nil))
    end
  end
end
