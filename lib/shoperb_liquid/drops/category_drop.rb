# frozen_string_literal: true

module ShoperbLiquid
  class CategoryDrop < Base
    def initialize(record)
      @record = record || Category.new
    end

    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def permalink
      record.permalink
    end

    def description
      record.description
    end

    def parent
      record.parent
    end

    def level
      record.level
    end

    def url
      record.id ? controller.store_category_path(record) : ""
    end

    def image
      ImageDrop.new(record.image) if record.image
    end

    def root
      CategoryDrop.new(record.root)
    end

    def root?
      record.root?
    end

    def current?
      record == current_category
    end

    def open?
      current_category && current_category.descends_from(record)
    end

    def descends_from(other)
      record.descends_from(other)
    end

    def parents
      CategoriesDrop.new(record.ancestors)
    end

    def children
      CategoriesDrop.new(record.children)
    end

    def children?
      record.children.any?
    end

    def products
      ProductsDrop.new(record.products.includes(:variants))
    end

    def products_with_children
      ProductsDrop.new(record.products_for_self_and_children)
    end

    def as_json(incl_children: false)
      out={
        id:             id,
        name:           name,
        permalink:      permalink,
        handle:         handle,
        description:    description,
        products_count: products_with_children.count,
        has_children:   children?,
        url:            url,
      }

      out[:children] = record.children.map do |e|
        e.to_liquid(@context).as_json(incl_children: incl_children)
      end if incl_children
      
      out
    end

    private

    def current_category
      controller.instance_variable_get("@category")
    end
  end
end
