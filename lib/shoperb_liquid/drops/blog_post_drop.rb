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
    
    def image
      ImageDrop.new(record.image) if record.image
    end

    def content
      locals = @context.environments[0].symbolize_keys
      record.content(@context.registers[:theme], controller, locals)
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
      controller.store_blog_post_path(record)
    end
  end
end
