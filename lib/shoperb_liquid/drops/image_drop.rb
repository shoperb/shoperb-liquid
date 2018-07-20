# frozen_string_literal: true

module ShoperbLiquid
  class ImageDrop < Base
    def width
      record.original_width || record.width
    end

    def height
      record.original_height || record.height
    end

    def url
      record.url
    end

    def aspect_ratio
      height * 1.0 / width
    end

    def liquid_method_missing(method, *args)
      if image = record.image_sizes.detect { |s| s.name == method.to_s }
        ImageDrop.new(image)
      end
    end
  end
end
