# frozen_string_literal: true

module ShoperbLiquid
  class LinkDrop < Base
    def id
      record.id
    end

    def url
      record.path(responder: controller)
    end

    def index_action?
      record.index_action?
    end

    def menu
      record.menu
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def object?
      !record.entity.nil?
    end

    def object
      record.entity
    end

    def parent
      record.parent
    end

    def children
      CollectionDrop.new(record.children)
    end

    def style
      record.style.try(:underscore)
    end

    def children?
      record.children.any?
    end
  end
end
