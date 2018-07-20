# frozen_string_literal: true

module ShoperbLiquid
  class MediaFileDrop < Base
    def id
      record.id
    end

    def mime
      record.mime
    end

    def extension
      record.extension
    end

    def filename
      record.filename
    end

    def url
      record.url
    end

    def image?
      record.image?
    end
  end
end
