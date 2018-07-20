# frozen_string_literal: true

module ShoperbLiquid
  class BlogPostDrop < Base
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

    def published_at
      record.published_at
    end

    def next
      self.class.new(nxt) if nxt = record.next
    end

    def prev
      self.class.new(prev) if prev = record.prev
    end

    def url
      routes.store_blog_post_path(record)
    end
  end
end
