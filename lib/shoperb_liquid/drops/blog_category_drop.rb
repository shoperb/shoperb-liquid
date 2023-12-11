# frozen_string_literal: true

module ShoperbLiquid
  class BlogCategoryDrop < Base
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


    def level
      record.level
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

    def blog_posts
      CollectionDrop.new(record.blog_posts)
    end
    
    def posts
      CollectionDrop.new(record.blog_posts)
    end

  end
end
